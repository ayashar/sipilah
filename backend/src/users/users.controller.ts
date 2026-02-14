import { Controller, Get, UseGuards } from '@nestjs/common';
import { UsersService } from './users.service.js';
import { AuthGuard } from '../common/guards/auth.guard.js';
import { RolesGuard } from '../common/guards/roles.guard.js';
import { Roles } from '../common/decorators/roles.decorator.js';
import { CurrentUser } from '../common/decorators/current-user.decorator.js';
import type { UserRecord } from '../common/interfaces/user-record.interface.js';

@Controller('users')
@UseGuards(AuthGuard, RolesGuard)
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get('dashboard/household')
  @Roles('household')
  async getHouseholdDashboard(@CurrentUser() user: UserRecord) {
    return this.usersService.getHouseholdDashboard(user.uid);
  }

  @Get('dashboard/collector')
  @Roles('collector')
  async getCollectorDashboard(@CurrentUser() user: UserRecord) {
    return this.usersService.getCollectorDashboard(user.uid);
  }
}
