import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class CustomMapProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // using U.Map to show custom maps from OpenTopoMap
    return U.Map(
      center: [51.555158, -0.108343],
      base: U.TileLayer(
        'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
        attribution:
            'Map data: &copy; OpenStreetMap contributors, SRTM | Map style: &copy; OpenTopoMap',
        maxZoom: 17,
      ),
    );
  }
}
