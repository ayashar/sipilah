import 'package:flutter/material.dart';
import '../shared/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Centering the content vertically
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // THE STACK (Card + Floating Avatar)
              Stack(
                clipBehavior: Clip.none, // Allows Avatar to go outside the box
                alignment: Alignment.topCenter,
                children: [
                  // 1. THE BIG GREEN CARD
                  Container(
                    margin: const EdgeInsets.only(
                      top: 50,
                    ), // Make room for head
                    padding: const EdgeInsets.fromLTRB(
                      24,
                      60,
                      24,
                      40,
                    ), // Top padding pushes text down
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // Uses the bright Lime Green from your palette (70E000 or 9EF01A)
                      color: AppColors.greenLevel6,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Name
                        const Text(
                          "Siti Nurhaliza",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        // Phone Number
                        Text(
                          "081234567890",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryDark.withOpacity(0.7),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Icon Wallet
                        Icon(
                          Icons.wallet,
                          size: 28,
                          color: AppColors.primaryDark,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Total Penghasilan",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        const Text(
                          "Rp 125.000",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Icon Recycle
                        Icon(
                          Icons.recycling,
                          size: 28,
                          color: AppColors.primaryDark,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Total Sampah",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        const Text(
                          "47, 5 Kg",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2. THE AVATAR (Floating on top)
                  Positioned(
                    top: 0, // Sits right at the top of the Stack area
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color:
                            AppColors.accentLime, // The lightest lime (9EF01A)
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.background,
                          width: 4,
                        ), // White/Cream border
                      ),
                      child: const Icon(
                        Icons.face_3, // Or Icons.person
                        size: 50,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // 3. LOGOUT BUTTON
              ElevatedButton(
                onPressed: () {
                  // Logout Logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.greenLevel5, // Slightly darker green button
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Hug content
                  children: const [
                    Text(
                      "Keluar",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
