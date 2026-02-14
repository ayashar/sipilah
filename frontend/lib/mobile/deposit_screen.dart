import 'package:flutter/material.dart';
import 'package:frontend/mobile/success_screen.dart';
import '../shared/theme/app_colors.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  // State to track which waste type is selected
  // 0 = Plastik, 1 = Kertas, 2 = Campuran
  int _selectedTypeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. HEADER (Back Button) ---
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.accentLime,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                      color: AppColors.primaryDark,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "Setor Sampah",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // --- 2. WASTE TYPE SELECTION ---
              const Text(
                "Jenis Sampah",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  // We use Expanded to make them equal width
                  Expanded(
                    child: _WasteTypeCard(
                      label: "Plastik",
                      icon: Icons.recycling,
                      isSelected: _selectedTypeIndex == 0,
                      onTap: () => setState(() => _selectedTypeIndex = 0),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _WasteTypeCard(
                      label: "Kertas",
                      icon: Icons.description,
                      isSelected: _selectedTypeIndex == 1,
                      onTap: () => setState(() => _selectedTypeIndex = 1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _WasteTypeCard(
                      label: "Campuran",
                      icon: Icons.delete_outline,
                      isSelected: _selectedTypeIndex == 2,
                      onTap: () => setState(() => _selectedTypeIndex = 2),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // --- 3. LOCATION CARD ---
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // Very light lime background
                  color: AppColors.accentLime.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.accentLime, width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.primaryDark,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Lokasi Penjemputan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDark,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Jl. Merdeka No. 12, RT 03/RW 05",
                            style: TextStyle(
                              color: AppColors.primaryDark,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // GPS Status Row
                          Row(
                            children: [
                              Icon(
                                Icons.my_location,
                                size: 14,
                                color: AppColors.primaryDark.withOpacity(0.6),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Terdeteksi otomatis (simulasi GPS)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primaryDark.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(), // Pushes the button to the bottom
              // --- 4. SUBMIT BUTTON ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuccessScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Kirim Permintaan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.send_rounded, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- HELPER WIDGET FOR THE SQUARES ---
class _WasteTypeCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _WasteTypeCard({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100, // Make them square-ish
        decoration: BoxDecoration(
          // If selected: Dark Green. If not: Bright Green (Level 5)
          color: isSelected ? AppColors.primaryDark : AppColors.greenLevel5,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (isSelected) // Add glow only if selected
              BoxShadow(
                color: AppColors.primaryDark.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
