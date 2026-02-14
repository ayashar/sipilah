import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // The Map Widget
import 'package:latlong2/latlong.dart'; // Coordinates helper
import '../../shared/theme/app_colors.dart';

class PickupMapScreen extends StatelessWidget {
  const PickupMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy "Pickup Location" (e.g., Monas, Jakarta)
    final LatLng pickupLocation = const LatLng(-6.175392, 106.827153);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lokasi Penjemputan"),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // 1. THE MAP
          FlutterMap(
            options: MapOptions(
              initialCenter: pickupLocation, // Center map here
              initialZoom: 15.0,
            ),
            children: [
              // A. The Tile Layer (The actual map images from OpenStreetMap)
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app', // Required by OSM
              ),

              // B. The Marker Layer (Your custom pin)
              MarkerLayer(
                markers: [
                  Marker(
                    point: pickupLocation,
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(blurRadius: 5, color: Colors.black26),
                            ],
                          ),
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                        // Optional: Label below marker
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Pickup Sini",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 2. BOTTOM CARD (Call to Action)
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.orange,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Penjemputan: 14:00 WIB",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to "Smart Weighing"
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Konfirmasi Lokasi"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
