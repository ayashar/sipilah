import { IsNumber, IsOptional, IsString, Min } from 'class-validator';

export class CompleteTransactionDto {
  @IsNumber()
  @Min(0.1)
  weightKg: number;

  @IsString()
  @IsOptional()
  proofImageUrl?: string;
}
