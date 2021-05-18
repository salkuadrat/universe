import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class MarkerSvgMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 15,
      markers: U.MarkerLayer(
        [
          [51.558374, -0.107398],
          [51.556674, -0.106215],
        ],
        widget: MarkerSvg(
          'assets/marker.svg',
          color: Colors.pink,
        ),
        size: 48,
      ),
    );
  }
}
