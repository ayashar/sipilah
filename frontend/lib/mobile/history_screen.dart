import 'package:flutter/material.dart';
import '../shared/theme/app_colors.dart';
import 'widgets/transaction_card.dart'; // Import the component we just made

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              // --- CUSTOM HEADER ---
              Row(
                children: [
                  // Back Button (Green Circle)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.accentLime, // The Lime Circle
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                      color: AppColors.primaryDark,
                      onPressed: () {
                        // In a full app, this might pop the navigator
                        // For this tab view, maybe it switches tab back to 0
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "Riwayat Transaksi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // --- LIST OF TRANSACTIONS ---
              // Expanded lets the list take up the rest of the screen
              Expanded(
                child: ListView(
                  children: const [
                    TransactionCard(
                      title: "Plastik",
                      date: "2026-02-13",
                      weight: "5.2 kg",
                      price: "+Rp 18.200",
                    ),
                    TransactionCard(
                      title: "Kertas",
                      date: "2026-02-13",
                      weight: "3 kg",
                      price: "+Rp 6.000",
                    ),
                    TransactionCard(
                      title: "Campuran",
                      date: "2026-02-13",
                      weight: "8.1 kg",
                      price: "+Rp 12.150",
                    ),
                    // Add more here to test scrolling...
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
