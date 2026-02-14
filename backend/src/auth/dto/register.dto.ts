import { IsString, IsNotEmpty, IsIn, ValidateNested, IsOptional } from 'class-validator';
import { Type } from 'class-transformer';

class AddressDto {
  @IsString()
  @IsNotEmpty()
  street: string;

  @IsString()
  @IsNotEmpty()
  rt_rw: string;

  @IsString()
  @IsOptional()
  fullAddress?: string;
}

class CoordinatesDto {
  @IsNotEmpty()
  lat: number;

  @IsNotEmpty()
  lng: number;
}

export class RegisterDto {
  @IsString()
  @IsNotEmpty()
  @IsIn(['household', 'collector', 'admin'])
  role: 'household' | 'collector' | 'admin';

  @IsString()
  @IsNotEmpty()
  fullName: string;

  @IsString()
  @IsNotEmpty()
  phoneNumber: string;

  @ValidateNested()
  @Type(() => AddressDto)
  address: AddressDto;

  @ValidateNested()
  @IsOptional()
  @Type(() => CoordinatesDto)
  coordinates?: CoordinatesDto;
}
