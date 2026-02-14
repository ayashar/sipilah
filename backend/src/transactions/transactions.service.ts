import {
  Injectable,
  NotFoundException,
  BadRequestException,
  Logger,
} from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service.js';
import { RequestTransactionDto } from './dto/request-transaction.dto.js';
import { CompleteTransactionDto } from './dto/complete-transaction.dto.js';
import { FieldValue } from 'firebase-admin/firestore';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class TransactionsService {
  private readonly logger = new Logger(TransactionsService.name);

  constructor(private readonly firebaseService: FirebaseService) {}

  /**
   * Household requests a waste pickup
   */
  async requestPickup(householdId: string, dto: RequestTransactionDto) {
    const db = this.firebaseService.firestore;

    // Fetch household name for denormalization
    const userDoc = await db.collection('users').doc(householdId).get();
    const userData = userDoc.data();

    if (!userData) {
      throw new NotFoundException('User not found');
    }

    const transactionId = uuidv4();

    const transaction = {
      transactionId,
      status: 'PENDING',
      householdId,
      householdName: userData.fullName,
      pickupLocation: {
        address: dto.pickupLocation.address,
        rt_rw: dto.pickupLocation.rt_rw || '',
        lat: dto.pickupLocation.lat,
        lng: dto.pickupLocation.lng,
      },
      collectorId: null,
      collectorName: null,
      wasteType: dto.wasteType,
      weightKg: null,
      pricePerKgSnapshot: null,
      totalAmount: null,
      createdAt: FieldValue.serverTimestamp(),
      assignedAt: null,
      completedAt: null,
      proofImageUrl: null,
    };

    await db.collection('transactions').doc(transactionId).set(transaction);

    this.logger.log(`Transaction created: ${transactionId} by household ${householdId}`);

    return { transactionId, status: 'PENDING' };
  }

  /**
   * Collector queries pending transactions nearby
   */
  async getNearbyPending() {
    const db = this.firebaseService.firestore;

    const snapshot = await db
      .collection('transactions')
      .where('status', '==', 'PENDING')
      .orderBy('createdAt', 'desc')
      .limit(50)
      .get();

    return snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
  }

  /**
   * Collector claims a pending transaction
   */
  async claimTransaction(transactionId: string, collectorId: string) {
    const db = this.firebaseService.firestore;
    const txRef = db.collection('transactions').doc(transactionId);

    const txDoc = await txRef.get();
    if (!txDoc.exists) {
      throw new NotFoundException('Transaction not found');
    }

    const txData = txDoc.data()!;
    if (txData.status !== 'PENDING') {
      throw new BadRequestException('Transaction is no longer pending');
    }

    // Fetch collector name for denormalization
    const collectorDoc = await db.collection('users').doc(collectorId).get();
    const collectorData = collectorDoc.data();

    await txRef.update({
      status: 'ASSIGNED',
      collectorId,
      collectorName: collectorData?.fullName || 'Unknown',
      assignedAt: FieldValue.serverTimestamp(),
    });

    this.logger.log(`Transaction ${transactionId} claimed by collector ${collectorId}`);

    return { transactionId, status: 'ASSIGNED' };
  }

  /**
   * Collector completes a transaction — the core atomic operation
   */
  async completeTransaction(
    transactionId: string,
    collectorId: string,
    dto: CompleteTransactionDto,
  ) {
    const db = this.firebaseService.firestore;
    const txRef = db.collection('transactions').doc(transactionId);

    const txDoc = await txRef.get();
    if (!txDoc.exists) {
      throw new NotFoundException('Transaction not found');
    }

    const txData = txDoc.data()!;
    if (txData.status !== 'ASSIGNED') {
      throw new BadRequestException('Transaction must be in ASSIGNED status to complete');
    }
    if (txData.collectorId !== collectorId) {
      throw new BadRequestException('You are not assigned to this transaction');
    }

    // 1. Fetch pricePerKg from waste_types
    const wasteTypeDoc = await db
      .collection('waste_types')
      .where('name', '==', txData.wasteType)
      .limit(1)
      .get();

    let pricePerKg = 0;
    if (!wasteTypeDoc.empty) {
      pricePerKg = wasteTypeDoc.docs[0].data().pricePerKg || 0;
    }

    // 2. Calculate totalAmount
    const totalAmount = Math.round(dto.weightKg * pricePerKg);

    // 3. Get today's date string for analytics_daily
    const today = new Date().toISOString().split('T')[0]; // YYYY-MM-DD

    // 4. Atomic batch write
    const batch = db.batch();

    // Update transaction → COMPLETED
    batch.update(txRef, {
      status: 'COMPLETED',
      weightKg: dto.weightKg,
      pricePerKgSnapshot: pricePerKg,
      totalAmount,
      completedAt: FieldValue.serverTimestamp(),
      proofImageUrl: dto.proofImageUrl || null,
    });

    // Increment household balance & stats
    const householdRef = db.collection('users').doc(txData.householdId);
    batch.update(householdRef, {
      balance: FieldValue.increment(totalAmount),
      'householdStats.totalWasteAccumulated': FieldValue.increment(dto.weightKg),
      'householdStats.participationScore': FieldValue.increment(1),
    });

    // Increment collector stats
    const collectorRef = db.collection('users').doc(collectorId);
    batch.update(collectorRef, {
      balance: FieldValue.increment(totalAmount),
      'collectorStats.totalPickups': FieldValue.increment(1),
      'collectorStats.totalWeightCollected': FieldValue.increment(dto.weightKg),
      'collectorStats.currentDayPickups': FieldValue.increment(1),
      'collectorStats.currentDayWeight': FieldValue.increment(dto.weightKg),
    });

    // Update analytics_daily
    const analyticsRef = db.collection('analytics_daily').doc(today);
    const wasteKey = txData.wasteType.toLowerCase();
    batch.set(
      analyticsRef,
      {
        date: today,
        totalWeight: FieldValue.increment(dto.weightKg),
        totalPayout: FieldValue.increment(totalAmount),
        transactionCount: FieldValue.increment(1),
        [`wasteComposition.${wasteKey}`]: FieldValue.increment(dto.weightKg),
      },
      { merge: true },
    );

    // Update global_stats
    const globalRef = db.collection('global_stats').doc('summary');
    batch.set(
      globalRef,
      {
        totalWasteAllTime: FieldValue.increment(dto.weightKg),
        totalPayoutAllTime: FieldValue.increment(totalAmount),
      },
      { merge: true },
    );

    await batch.commit();

    this.logger.log(
      `Transaction ${transactionId} completed: ${dto.weightKg}kg @ Rp${pricePerKg}/kg = Rp${totalAmount}`,
    );

    return {
      transactionId,
      status: 'COMPLETED',
      weightKg: dto.weightKg,
      pricePerKg,
      totalAmount,
    };
  }

  /**
   * Get transaction history for a user
   */
  async getHistory(uid: string, role: string) {
    const db = this.firebaseService.firestore;

    const field = role === 'collector' ? 'collectorId' : 'householdId';

    const snapshot = await db
      .collection('transactions')
      .where(field, '==', uid)
      .orderBy('createdAt', 'desc')
      .limit(50)
      .get();

    return snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
  }

  /**
   * Cancel a pending transaction (by household)
   */
  async cancelTransaction(transactionId: string, householdId: string) {
    const db = this.firebaseService.firestore;
    const txRef = db.collection('transactions').doc(transactionId);

    const txDoc = await txRef.get();
    if (!txDoc.exists) {
      throw new NotFoundException('Transaction not found');
    }

    const txData = txDoc.data()!;
    if (txData.householdId !== householdId) {
      throw new BadRequestException('You do not own this transaction');
    }
    if (txData.status !== 'PENDING') {
      throw new BadRequestException('Only pending transactions can be cancelled');
    }

    await txRef.update({
      status: 'CANCELLED',
    });

    return { transactionId, status: 'CANCELLED' };
  }
}
