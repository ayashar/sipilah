import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WastePieChartWidget extends StatelessWidget {
  const WastePieChartWidget({super.key});

  static const List<_WasteSlice> _dummyData = [
    _WasteSlice(label: "Plastik", percent: 42, color: Colors.green),
    _WasteSlice(label: "Kertas", percent: 30, color: Colors.blue),
    _WasteSlice(label: "Campuran", percent: 28, color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        centerSpaceRadius: 0,
        sectionsSpace: 2,

        sections: _dummyData
            .map(
              (slice) => PieChartSectionData(
                value: slice.percent.toDouble(),
                title: "${slice.label} ${slice.percent}%",
                color: slice.color,
                radius: 90,
                titleStyle: const TextStyle(fontSize: 12),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _WasteSlice {
  final String label;
  final int percent;
  final Color color;

  const _WasteSlice({
    required this.label,
    required this.percent,
    required this.color,
  });
}
