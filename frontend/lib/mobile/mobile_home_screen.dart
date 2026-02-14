import 'package:flutter/material.dart';
import 'package:frontend/mobile/deposit_screen.dart';
import '../shared/theme/app_colors.dart';
import 'widgets/transaction_card.dart';
import 'history_screen.dart'; // Import the new screen
import 'profile_screen.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({super.key});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  // 1. STATE: Which tab is active?
  int _selectedIndex = 0;

  // 2. DATA: The list of pages
  final List<Widget> _pages = [
    const HomeContent(), // The Home Page (Code below)
    const HistoryScreen(), // The History Page (From Step 2)
    const ProfileScreen(), // The Profile Page (From Step 3)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 3. BODY: Show the widget for the current index
      body: _pages[_selectedIndex],

      // 4. BOTTOM NAV: Updates the state
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Beranda",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

// --- ORIGINAL HOME CONTENT (Moved here to keep file clean) ---
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    // This is the EXACT code you had before for the Home Body
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 50,
      ), // Added top padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting
          const Text(
            "Selamat datang,",
            style: TextStyle(fontSize: 14, color: AppColors.greenLevel2),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Siti Nurhaliza",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.accentLime,
                child: const Icon(
                  Icons.support_agent,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Hero Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.greenLevel5,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greenLevel5.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.wallet,
                          color: AppColors.primaryDark.withOpacity(0.5),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Saldo Anda",
                          style: TextStyle(
                            color: AppColors.primaryDark.withOpacity(0.6),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.trending_up,
                        color: AppColors.primaryDark,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  "Rp. 125.000",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Icon(
                      Icons.recycling,
                      color: AppColors.primaryDark.withOpacity(0.5),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Total Sampah: 47,5 Kg",
                      style: TextStyle(
                        color: AppColors.primaryDark.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the Deposit Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DepositScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Setor Sampah",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Transactions Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Transaksi terakhir",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Lihat semua",
                  style: TextStyle(color: AppColors.greenLevel4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Reuse the Widget!
          const TransactionCard(
            title: "Plastik",
            date: "2026-02-13",
            weight: "5.2 kg",
            price: "+Rp 18.200",
          ),
          const TransactionCard(
            title: "Kertas",
            date: "2026-02-13",
            weight: "3 kg",
            price: "+Rp 6.000",
          ),
          const TransactionCard(
            title: "Campuran",
            date: "2026-02-13",
            weight: "8.1 kg",
            price: "+Rp 12.150",
          ),
        ],
      ),
    );
  }
}
