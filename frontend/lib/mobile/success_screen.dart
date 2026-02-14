import 'package:flutter/material.dart';
import '../shared/theme/app_colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. ICON LOGO (Subtle background icon)
            Icon(
              Icons.description_outlined,
              size: 100,
              color: AppColors.primaryDark.withOpacity(0.05),
            ),
            const SizedBox(height: 40),

            // 2. SUCCESS CHECKMARK (The Green Circle)
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: AppColors.greenLevel4, // 008000
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 80,
              ),
            ),

            const SizedBox(height: 32),

            // 3. TEXT STATUS
            const Text(
              "Permintaan Terkirim!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: 12),

            // RichText for the colored status
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 18, color: AppColors.primaryDark),
                children: [
                  TextSpan(text: "Status: "),
                  TextSpan(
                    text: "Menunggu Penjemput",
                    style: TextStyle(
                      color: Colors.orange, // Based on image yellow/orange
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // 4. BACK TO HOME BUTTON
            ElevatedButton(
              onPressed: () {
                // Clear the navigation stack and return to Home
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenLevel1, // 004B23
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Kembali ke Beranda",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
