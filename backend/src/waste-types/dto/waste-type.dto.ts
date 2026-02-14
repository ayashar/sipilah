import { IsString, IsNotEmpty, IsNumber, IsOptional } from 'class-validator';

export class CreateWasteTypeDto {
  @IsString()
  @IsNotEmpty()
  id: string;

  @IsString()
  @IsNotEmpty()
  name: string;

  @IsNumber()
  pricePerKg: number;

  @IsString()
  @IsOptional()
  colorCode?: string;

  @IsString()
  @IsOptional()
  description?: string;
}

export class UpdateWasteTypeDto {
  @IsString()
  @IsOptional()
  name?: string;

  @IsNumber()
  @IsOptional()
  pricePerKg?: number;

  @IsString()
  @IsOptional()
  colorCode?: string;

  @IsString()
  @IsOptional()
  description?: string;
}
