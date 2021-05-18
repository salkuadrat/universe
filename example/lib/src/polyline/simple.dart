import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class PolylineMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555015, -0.108331],
      zoom: 16,
      // by default, PolylineLayer will use style from theme primaryColor
      polylines: U.PolylineLayer(
        [
          [51.556650, -0.108170],
          [51.554508, -0.109983],
          [51.553968, -0.109650],
          [51.554081, -0.107097],
          [51.556203, -0.107762],
        ],
      ),
    );
  }
}
