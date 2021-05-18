import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class MaxBoundsMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555158, -0.108343],
      zoom: 16,
      maxBounds: LatLngBounds(
        [51.293714, -0.527292], // southWest bound
        [51.669162, 0.256857], // northEast bound
      ),
      // draw rectangle to visualize the bounds
      rectangles: U.RectangleLayer(
        [
          [51.293714, -0.527292],
          [51.669162, 0.256857],
        ],
        stroke: false,
        fillColor: Colors.white,
        fillOpacity: 0.2,
      ),
    );
  }
}
