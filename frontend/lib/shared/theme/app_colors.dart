import 'package:flutter/material.dart';

class AppColors {
  // --- PRIMITIVES (Your Exact Palette) ---
  static const Color greenLevel1 = Color(
    0xFF004B23,
  ); // Darkest (Text / Buttons)
  static const Color greenLevel2 = Color(0xFF006400);
  static const Color greenLevel3 = Color(0xFF007200);
  static const Color greenLevel4 = Color(0xFF008000); // Standard Green
  static const Color greenLevel5 = Color(
    0xFF38B000,
  ); // Vibrant (Card Background)
  static const Color greenLevel6 = Color(0xFF70E000);
  static const Color greenLevel7 = Color(0xFF9EF01A); // Lime Accent
  static const Color cream = Color(0xFFFAFFEB); // Background

  // --- SEMANTICS (How we use them) ---

  // The main background of the phone
  static const Color background = cream;

  // The "Setor Sampah" button & Main Text
  static const Color primaryDark = greenLevel1;

  // The "Saldo Anda" Big Card background
  static const Color cardGreen = greenLevel5;

  // The Lime accents (like the graph icon circle)
  static const Color accentLime = greenLevel7;

  // White is still needed for the Transaction Cards
  static const Color white = Colors.white;
}
