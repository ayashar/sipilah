import { Injectable, Logger } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service.js';

@Injectable()
export class AdminService {
  private readonly logger = new Logger(AdminService.name);

  constructor(private readonly firebaseService: FirebaseService) {}

  /**
   * GET /admin/overview — returns global_stats summary
   */
  async getOverview() {
    const db = this.firebaseService.firestore;
    const doc = await db.collection('global_stats').doc('summary').get();

    if (!doc.exists) {
      return {
        totalWasteAllTime: 0,
        totalPayoutAllTime: 0,
        totalActiveUsers: 0,
        totalActiveCollectors: 0,
        averageWastePerUser: 0,
        participationRate: 0,
      };
    }

    return doc.data();
  }

  /**
   * GET /admin/charts/daily — returns analytics_daily data for charting
   */
  async getDailyCharts(startDate?: string, endDate?: string) {
    const db = this.firebaseService.firestore;

    let query = db.collection('analytics_daily').orderBy('date', 'desc');

    if (startDate) {
      query = query.where('date', '>=', startDate) as any;
    }
    if (endDate) {
      query = query.where('date', '<=', endDate) as any;
    }

    const snapshot = await query.limit(30).get();

    return snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
  }

  /**
   * GET /admin/financial-monitor — paginated completed transactions
   */
  async getFinancialMonitor(limit: number = 20, startAfterDate?: string) {
    const db = this.firebaseService.firestore;

    let query = db
      .collection('transactions')
      .where('status', '==', 'COMPLETED')
      .orderBy('completedAt', 'desc')
      .limit(limit);

    if (startAfterDate) {
      const startDoc = await db
        .collection('transactions')
        .doc(startAfterDate)
        .get();
      if (startDoc.exists) {
        query = query.startAfter(startDoc);
      }
    }

    const snapshot = await query.get();

    const transactions = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    return {
      data: transactions,
      count: transactions.length,
      hasMore: transactions.length === limit,
      lastId: transactions.length > 0 ? transactions[transactions.length - 1].id : null,
    };
  }

  /**
   * GET /admin/performance/collectors — collector leaderboard
   */
  async getCollectorPerformance() {
    const db = this.firebaseService.firestore;

    const snapshot = await db
      .collection('users')
      .where('role', '==', 'collector')
      .orderBy('collectorStats.totalPickups', 'desc')
      .limit(50)
      .get();

    return snapshot.docs.map((doc) => {
      const data = doc.data();
      return {
        uid: doc.id,
        fullName: data.fullName,
        phoneNumber: data.phoneNumber,
        totalPickups: data.collectorStats?.totalPickups || 0,
        totalWeightCollected: data.collectorStats?.totalWeightCollected || 0,
        currentDayPickups: data.collectorStats?.currentDayPickups || 0,
        currentDayWeight: data.collectorStats?.currentDayWeight || 0,
      };
    });
  }
}
