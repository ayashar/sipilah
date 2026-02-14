import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

class KeuanganPage extends StatelessWidget {
  const KeuanganPage({super.key});

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
              "Monitoring Keuangan",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: "Total Disalurkan",
                    value: "Rp 3.450.000",
                    valueColor: Colors.orange,
                  ),
                ),

                const SizedBox(width: 24),

                const Expanded(
                  child: _SummaryCard(title: "Jumlah Transaksi", value: "5"),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _MainCard(
              title: "Ringkasan Mikro Pembayaran",
              child: _TransactionTable(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const _SummaryCard({
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),

          const SizedBox(height: 8),

          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _MainCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _MainCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
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

          child,
        ],
      ),
    );
  }
}

class _TransactionTable extends StatelessWidget {
  final List<Map<String, dynamic>> dummyData = const [
    {
      "date": "10 Feb 2026",
      "user": "Budi Santoso",
      "amount": 750000,
      "status": "Sukses",
    },
    {
      "date": "11 Feb 2026",
      "user": "Andi Wijaya",
      "amount": 500000,
      "status": "Sukses",
    },
    {
      "date": "12 Feb 2026",
      "user": "Siti Rahma",
      "amount": 650000,
      "status": "Sukses",
    },
    {
      "date": "13 Feb 2026",
      "user": "Dewi Lestari",
      "amount": 800000,
      "status": "Pending",
    },
    {
      "date": "14 Feb 2026",
      "user": "Rizky Pratama",
      "amount": 750000,
      "status": "Sukses",
    },
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
            DataColumn(label: Text("Tanggal")),
            DataColumn(label: Text("Nama")),
            DataColumn(label: Text("Nominal")),
            DataColumn(label: Text("Status")),
          ],
          rows: dummyData.map((item) {
            return DataRow(
              cells: [
                DataCell(Text(item["date"])),
                DataCell(Text(item["user"])),
                DataCell(
                  Text(
                    "Rp ${item["amount"]}",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                DataCell(_StatusBadge(status: item["status"])),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isSuccess = status == "Sukses";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

      decoration: BoxDecoration(
        color: isSuccess
            ? Colors.green.withAlpha(15)
            : Colors.orange.withAlpha(15),

        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        status,
        style: TextStyle(
          color: isSuccess ? Colors.green : Colors.orange,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
