import { Module } from '@nestjs/common';
import { WasteTypesController } from './waste-types.controller.js';
import { WasteTypesService } from './waste-types.service.js';

@Module({
  controllers: [WasteTypesController],
  providers: [WasteTypesService],
  exports: [WasteTypesService],
})
export class WasteTypesModule {}
