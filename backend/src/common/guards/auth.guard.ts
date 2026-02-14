import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
  Logger,
} from '@nestjs/common';
import { FirebaseService } from '../../firebase/firebase.service.js';
import { UserRecord } from '../interfaces/user-record.interface.js';

@Injectable()
export class AuthGuard implements CanActivate {
  private readonly logger = new Logger(AuthGuard.name);

  constructor(private readonly firebaseService: FirebaseService) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest();
    const authHeader = request.headers['authorization'];

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      throw new UnauthorizedException('Missing or invalid authorization header');
    }

    const token = authHeader.split('Bearer ')[1];

    try {
      const decodedToken = await this.firebaseService.auth.verifyIdToken(token);

      // Fetch user role from Firestore
      const userDoc = await this.firebaseService.firestore
        .collection('users')
        .doc(decodedToken.uid)
        .get();

      const userData = userDoc.data();

      const user: UserRecord = {
        uid: decodedToken.uid,
        role: userData?.role || 'household',
        email: decodedToken.email,
      };

      request.user = user;
      return true;
    } catch (error) {
      this.logger.error('Token verification failed', error);
      throw new UnauthorizedException('Invalid or expired token');
    }
  }
}
