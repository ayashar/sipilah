import { Injectable, Logger } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service.js';
import { RegisterDto } from './dto/register.dto.js';
import { FieldValue } from 'firebase-admin/firestore';

@Injectable()
export class AuthService {
  private readonly logger = new Logger(AuthService.name);

  constructor(private readonly firebaseService: FirebaseService) {}

  async register(uid: string, dto: RegisterDto) {
    const db = this.firebaseService.firestore;

    const userData: Record<string, any> = {
      uid,
      role: dto.role,
      fullName: dto.fullName,
      phoneNumber: dto.phoneNumber,
      address: {
        street: dto.address.street,
        rt_rw: dto.address.rt_rw,
        fullAddress: dto.address.fullAddress || `${dto.address.street}, ${dto.address.rt_rw}`,
      },
      coordinates: dto.coordinates || null,
      balance: 0,
      createdAt: FieldValue.serverTimestamp(),
    };

    // Add role-specific stats
    if (dto.role === 'household') {
      userData.householdStats = {
        totalWasteAccumulated: 0,
        participationScore: 0,
      };
    } else if (dto.role === 'collector') {
      userData.collectorStats = {
        totalPickups: 0,
        totalWeightCollected: 0,
        currentDayPickups: 0,
        currentDayWeight: 0,
      };
    }

    await db.collection('users').doc(uid).set(userData);

    // Set custom claims for role-based auth
    await this.firebaseService.auth.setCustomUserClaims(uid, { role: dto.role });

    this.logger.log(`User registered: ${uid} as ${dto.role}`);

    return { uid, role: dto.role, fullName: dto.fullName };
  }
}
