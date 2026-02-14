import { Controller, Get, Query, UseGuards } from '@nestjs/common';
import { AdminService } from './admin.service.js';
import { AuthGuard } from '../common/guards/auth.guard.js';
import { RolesGuard } from '../common/guards/roles.guard.js';
import { Roles } from '../common/decorators/roles.decorator.js';

@Controller('admin')
@UseGuards(AuthGuard, RolesGuard)
@Roles('admin')
export class AdminController {
  constructor(private readonly adminService: AdminService) {}

  @Get('overview')
  async getOverview() {
    return this.adminService.getOverview();
  }

  @Get('charts/daily')
  async getDailyCharts(
    @Query('startDate') startDate?: string,
    @Query('endDate') endDate?: string,
  ) {
    return this.adminService.getDailyCharts(startDate, endDate);
  }

  @Get('financial-monitor')
  async getFinancialMonitor(
    @Query('limit') limit?: string,
    @Query('startAfter') startAfter?: string,
  ) {
    return this.adminService.getFinancialMonitor(
      limit ? parseInt(limit, 10) : 20,
      startAfter,
    );
  }

  @Get('performance/collectors')
  async getCollectorPerformance() {
    return this.adminService.getCollectorPerformance();
  }
}
