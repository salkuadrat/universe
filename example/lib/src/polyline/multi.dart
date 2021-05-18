import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class MultiPolylineMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555015, -0.108331],
      zoom: 16,
      // multiple polylines with similar styles
      polylines: U.PolylineLayer(
        [
          [
            [51.556650, -0.108170],
            [51.554508, -0.109983],
            [51.553968, -0.109650],
            [51.554081, -0.107097],
            [51.556203, -0.107762],
          ],
          [
            [51.555856, -0.108363],
            [51.555069, -0.109414],
            [51.554228, -0.108481],
            [51.555035, -0.107311],
            [51.555062, -0.108363],
          ]
        ],
        strokeColor: Colors.pink,
        strokeOpacity: 0.8,
        isDotted: true,
      ),
    );
  }
}
