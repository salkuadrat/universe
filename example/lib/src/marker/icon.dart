import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class MarkerIconMap extends StatelessWidget {
  const MarkerIconMap({super.key});

  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 16,
      markers: U.MarkerLayer(
        [
          [51.558374, -0.107398],
          [51.556674, -0.106215],
        ],
        widget: const MarkerIcon(
          icon: Icons.location_on,
          color: Colors.red,
        ),
      ),
    );
  }
}
