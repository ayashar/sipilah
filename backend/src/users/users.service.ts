import { Injectable } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service.js';

@Injectable()
export class UsersService {
  constructor(private readonly firebaseService: FirebaseService) {}

  async getHouseholdDashboard(uid: string) {
    const db = this.firebaseService.firestore;

    // Fetch user profile
    const userDoc = await db.collection('users').doc(uid).get();
    const userData = userDoc.data();

    // Fetch recent transactions (last 10)
    const transactionsSnap = await db
      .collection('transactions')
      .where('householdId', '==', uid)
      .orderBy('createdAt', 'desc')
      .limit(10)
      .get();

    const recentTransactions = transactionsSnap.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    return {
      profile: {
        fullName: userData?.fullName,
        phoneNumber: userData?.phoneNumber,
        address: userData?.address,
        balance: userData?.balance || 0,
      },
      stats: userData?.householdStats || {
        totalWasteAccumulated: 0,
        participationScore: 0,
      },
      recentTransactions,
    };
  }

  async getCollectorDashboard(uid: string) {
    const db = this.firebaseService.firestore;

    // Fetch user profile
    const userDoc = await db.collection('users').doc(uid).get();
    const userData = userDoc.data();

    // Fetch assigned (active) pickups
    const assignedSnap = await db
      .collection('transactions')
      .where('collectorId', '==', uid)
      .where('status', '==', 'ASSIGNED')
      .orderBy('assignedAt', 'desc')
      .get();

    const assignedPickups = assignedSnap.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    // Fetch recent completed transactions
    const completedSnap = await db
      .collection('transactions')
      .where('collectorId', '==', uid)
      .where('status', '==', 'COMPLETED')
      .orderBy('completedAt', 'desc')
      .limit(10)
      .get();

    const recentCompleted = completedSnap.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    return {
      profile: {
        fullName: userData?.fullName,
        phoneNumber: userData?.phoneNumber,
        balance: userData?.balance || 0,
      },
      dailyStats: {
        currentDayPickups: userData?.collectorStats?.currentDayPickups || 0,
        currentDayWeight: userData?.collectorStats?.currentDayWeight || 0,
      },
      totalStats: {
        totalPickups: userData?.collectorStats?.totalPickups || 0,
        totalWeightCollected: userData?.collectorStats?.totalWeightCollected || 0,
      },
      assignedPickups,
      recentCompleted,
    };
  }
}
