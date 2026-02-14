import { Controller, Post, Body, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service.js';
import { RegisterDto } from './dto/register.dto.js';
import { AuthGuard } from '../common/guards/auth.guard.js';
import { CurrentUser } from '../common/decorators/current-user.decorator.js';
import type { UserRecord } from '../common/interfaces/user-record.interface.js';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('register')
  @UseGuards(AuthGuard)
  async register(
    @CurrentUser() user: UserRecord,
    @Body() registerDto: RegisterDto,
  ) {
    return this.authService.register(user.uid, registerDto);
  }
}
