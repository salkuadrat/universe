import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class MultiRectangleMap extends StatelessWidget {
  const MultiRectangleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      center: [-6.175329, 106.827253],
      zoom: 15,
      rectangles: U.RectangleLayer(
        [
          [
            [-6.183200, 106.823205],
            [-6.180427, 106.831809],
          ],
          [
            [-6.177590, 106.825007],
            [-6.173344, 106.829234],
          ],
          [
            [-6.171083, 106.823290],
            [-6.167542, 106.825307],
          ],
        ],
        stroke: true,
        strokeColor: Colors.yellow,
        fillColor: Colors.lightBlue,
        fillOpacity: 0.6,
      ),
    );
  }
}
