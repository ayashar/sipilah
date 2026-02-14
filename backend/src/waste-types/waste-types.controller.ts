import { Controller, Get, Post, Patch, Param, Body, UseGuards } from '@nestjs/common';
import { WasteTypesService } from './waste-types.service.js';
import { CreateWasteTypeDto, UpdateWasteTypeDto } from './dto/waste-type.dto.js';
import { AuthGuard } from '../common/guards/auth.guard.js';
import { RolesGuard } from '../common/guards/roles.guard.js';
import { Roles } from '../common/decorators/roles.decorator.js';

@Controller('waste-types')
export class WasteTypesController {
  constructor(private readonly wasteTypesService: WasteTypesService) {}

  @Get()
  async findAll() {
    return this.wasteTypesService.findAll();
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.wasteTypesService.findOne(id);
  }

  @Post()
  @UseGuards(AuthGuard, RolesGuard)
  @Roles('admin')
  async create(@Body() dto: CreateWasteTypeDto) {
    return this.wasteTypesService.create(dto);
  }

  @Patch(':id')
  @UseGuards(AuthGuard, RolesGuard)
  @Roles('admin')
  async update(@Param('id') id: string, @Body() dto: UpdateWasteTypeDto) {
    return this.wasteTypesService.update(id, dto);
  }
}
