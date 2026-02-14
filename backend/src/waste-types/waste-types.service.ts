import { Injectable, NotFoundException } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service.js';
import { CreateWasteTypeDto, UpdateWasteTypeDto } from './dto/waste-type.dto.js';

@Injectable()
export class WasteTypesService {
  constructor(private readonly firebaseService: FirebaseService) {}

  async findAll() {
    const db = this.firebaseService.firestore;
    const snapshot = await db.collection('waste_types').get();

    return snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
  }

  async findOne(id: string) {
    const db = this.firebaseService.firestore;
    const doc = await db.collection('waste_types').doc(id).get();

    if (!doc.exists) {
      throw new NotFoundException(`Waste type "${id}" not found`);
    }

    return { id: doc.id, ...doc.data() };
  }

  async create(dto: CreateWasteTypeDto) {
    const db = this.firebaseService.firestore;

    await db.collection('waste_types').doc(dto.id).set({
      id: dto.id,
      name: dto.name,
      pricePerKg: dto.pricePerKg,
      colorCode: dto.colorCode || '#22C55E',
      description: dto.description || '',
    });

    return { ...dto };
  }

  async update(id: string, dto: UpdateWasteTypeDto) {
    const db = this.firebaseService.firestore;
    const docRef = db.collection('waste_types').doc(id);
    const doc = await docRef.get();

    if (!doc.exists) {
      throw new NotFoundException(`Waste type "${id}" not found`);
    }

    const updateData: Record<string, any> = {};
    if (dto.name !== undefined) updateData.name = dto.name;
    if (dto.pricePerKg !== undefined) updateData.pricePerKg = dto.pricePerKg;
    if (dto.colorCode !== undefined) updateData.colorCode = dto.colorCode;
    if (dto.description !== undefined) updateData.description = dto.description;

    await docRef.update(updateData);

    return { id, ...doc.data(), ...updateData };
  }
}
