import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/navbar.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: const NavbarWidget() as PreferredSizeWidget,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Analytics",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: _buildCard(
                    title: "Tren Sampah Harian",
                    child: _WasteBarChart(),
                  ),
                ),

                const SizedBox(width: 24),

                Expanded(
                  child: _buildCard(
                    title: "Tren Pembayaran Harian",
                    child: _PaymentLineChart(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _buildCard(title: "Performa Penjemput", child: _CollectorTable()),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 16),

          SizedBox(height: 240, child: child),
        ],
      ),
    );
  }
}

class _WasteBarChart extends StatelessWidget {
  final List<double> data = [45, 52, 38, 60, 55, 48, 68];

  final List<String> labels = [
    "08 Feb",
    "09 Feb",
    "10 Feb",
    "11 Feb",
    "12 Feb",
    "13 Feb",
    "14 Feb",
  ];

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: 80,

        gridData: FlGridData(show: true),

        borderData: FlBorderData(show: false),

        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,

              getTitlesWidget: (value, meta) {
                return Text(
                  labels[value.toInt()],
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
        ),

        barGroups: List.generate(
          data.length,
          (i) => BarChartGroupData(
            x: i,

            barRods: [
              BarChartRodData(
                toY: data[i],
                color: Colors.green,
                width: 24,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentLineChart extends StatelessWidget {
  final List<double> data = [
    120000,
    145000,
    100000,
    170000,
    155000,
    130000,
    190000,
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 200000,

        gridData: FlGridData(show: true),

        borderData: FlBorderData(show: false),

        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),

        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              data.length,
              (i) => FlSpot(i.toDouble(), data[i]),
            ),

            color: Colors.orange,
            barWidth: 3,

            isCurved: true,

            dotData: FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}

class _CollectorTable extends StatelessWidget {
  final List<Map<String, dynamic>> dummyData = const [
    {"name": "Budi Santoso", "pickup": 45, "weight": 312.5},
    {"name": "Andi Wijaya", "pickup": 38, "weight": 280.2},
    {"name": "Siti Rahma", "pickup": 42, "weight": 298.7},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width - 88,
        ),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(Colors.grey.shade100),
          columnSpacing: 32,
          columns: const [
            DataColumn(label: Text("Nama")),
            DataColumn(label: Text("Penjemputan")),
            DataColumn(label: Text("Berat (Kg)")),
          ],
          rows: dummyData.map((item) {
            return DataRow(
              cells: [
                DataCell(Text(item["name"])),
                DataCell(Text(item["pickup"].toString())),
                DataCell(Text(item["weight"].toString())),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
