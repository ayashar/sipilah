import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get mobileTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter', // Or 'Geist' if you added it
      // 1. Global Background (Cream)
      scaffoldBackgroundColor: AppColors.background,

      // 2. Color Engine
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryDark,
        primary: AppColors.primaryDark, // For Buttons & Active States
        secondary: AppColors.accentLime, // For Highlights
        surface: AppColors.white, // For specific cards (Transactions)
        background: AppColors.background,
      ),

      // 3. Text (Dark Green by default)
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.primaryDark),
        bodyMedium: TextStyle(color: AppColors.primaryDark),
        titleLarge: TextStyle(
          color: AppColors.primaryDark,
          fontWeight: FontWeight.bold,
        ),
      ),

      // 4. App Bar (Cream bg, Dark Green text)
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primaryDark,
        elevation: 0,
        centerTitle: false,
      ),

      // 5. Buttons (Dark Green background, Lime text/icon)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark, // 004B23
          foregroundColor: Colors.white, // Text color
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
