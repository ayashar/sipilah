import 'package:flutter/material.dart';

import '../widgets/navbar.dart';
import '../widgets/stat_card.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/waste_pie_chart.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      appBar: const NavbarWidget() as PreferredSizeWidget,

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Dashboard Overview",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            Row(
              children: const [
                Expanded(
                  child: StatCardWidget(
                    title: "Total Sampah",
                    value: "1247.5 kg",
                    icon: Icons.recycling,
                  ),
                ),

                SizedBox(width: 16),

                Expanded(
                  child: StatCardWidget(
                    title: "Total Sampah",
                    value: "1247.5 kg",
                    icon: Icons.recycling,
                  ),
                ),

                SizedBox(width: 16),

                Expanded(
                  child: StatCardWidget(
                    title: "Total Sampah",
                    value: "1247.5 kg",
                    icon: Icons.recycling,
                  ),
                ),

                SizedBox(width: 16),

                Expanded(
                  child: StatCardWidget(
                    title: "Total Sampah",
                    value: "1247.5 kg",
                    icon: Icons.recycling,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: DashboardCardWidget(
                      title: "Komposisi Sampah",
                      child: const WastePieChartWidget(),
                    ),
                  ),

                  const SizedBox(width: 24),

                  Expanded(
                    child: DashboardCardWidget(
                      title: "Lokasi Penjemputan",
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.map_outlined,
                              size: 80,
                              color: Colors.grey,
                            ),
                            Text(
                              "Heat Map feature is under development",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
