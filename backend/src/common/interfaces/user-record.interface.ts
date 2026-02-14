export interface UserRecord {
  uid: string;
  role: 'household' | 'collector' | 'admin';
  email?: string;
}
