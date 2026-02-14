import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { UserRecord } from '../interfaces/user-record.interface.js';

export const CurrentUser = createParamDecorator(
  (data: unknown, ctx: ExecutionContext): UserRecord => {
    const request = ctx.switchToHttp().getRequest();
    return request.user as UserRecord;
  },
);
