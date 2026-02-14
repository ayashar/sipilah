import { IsString, IsNotEmpty, IsOptional, ValidateNested, IsNumber } from 'class-validator';
import { Type } from 'class-transformer';

class PickupLocationDto {
  @IsString()
  @IsNotEmpty()
  address: string;

  @IsString()
  @IsOptional()
  rt_rw?: string;

  @IsNumber()
  lat: number;

  @IsNumber()
  lng: number;
}

export class RequestTransactionDto {
  @IsString()
  @IsNotEmpty()
  wasteType: string; // "Plastik", "Kertas", "Campuran"

  @ValidateNested()
  @Type(() => PickupLocationDto)
  pickupLocation: PickupLocationDto;
}
