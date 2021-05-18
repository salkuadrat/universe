import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class RectangleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555015, -0.108331],
      zoom: 16,
      rectangles: U.RectangleLayer(
        [
          [51.554488, -0.108964], // latlng bottom left corner
          [51.555682, -0.107580], // latlng top right corner
        ],
      ),
    );
  }
}
