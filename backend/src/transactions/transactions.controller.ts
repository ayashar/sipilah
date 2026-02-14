import {
  Controller,
  Get,
  Post,
  Patch,
  Param,
  Body,
  UseGuards,
} from '@nestjs/common';
import { TransactionsService } from './transactions.service.js';
import { RequestTransactionDto } from './dto/request-transaction.dto.js';
import { CompleteTransactionDto } from './dto/complete-transaction.dto.js';
import { AuthGuard } from '../common/guards/auth.guard.js';
import { RolesGuard } from '../common/guards/roles.guard.js';
import { Roles } from '../common/decorators/roles.decorator.js';
import { CurrentUser } from '../common/decorators/current-user.decorator.js';
import type { UserRecord } from '../common/interfaces/user-record.interface.js';

@Controller('transactions')
@UseGuards(AuthGuard, RolesGuard)
export class TransactionsController {
  constructor(private readonly transactionsService: TransactionsService) {}

  @Post('request')
  @Roles('household')
  async requestPickup(
    @CurrentUser() user: UserRecord,
    @Body() dto: RequestTransactionDto,
  ) {
    return this.transactionsService.requestPickup(user.uid, dto);
  }

  @Get('nearby')
  @Roles('collector')
  async getNearbyPending() {
    return this.transactionsService.getNearbyPending();
  }

  @Patch(':id/claim')
  @Roles('collector')
  async claimTransaction(
    @Param('id') id: string,
    @CurrentUser() user: UserRecord,
  ) {
    return this.transactionsService.claimTransaction(id, user.uid);
  }

  @Post(':id/complete')
  @Roles('collector')
  async completeTransaction(
    @Param('id') id: string,
    @CurrentUser() user: UserRecord,
    @Body() dto: CompleteTransactionDto,
  ) {
    return this.transactionsService.completeTransaction(id, user.uid, dto);
  }

  @Get('history')
  async getHistory(@CurrentUser() user: UserRecord) {
    return this.transactionsService.getHistory(user.uid, user.role);
  }

  @Patch(':id/cancel')
  @Roles('household')
  async cancelTransaction(
    @Param('id') id: string,
    @CurrentUser() user: UserRecord,
  ) {
    return this.transactionsService.cancelTransaction(id, user.uid);
  }
}
