import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class RectangleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      type: MapBoxType.Hybrid,
      accessToken: yourAccessTokenHere,
      center: [51.555015,-0.108331], 
      zoom: 16,
      rectangles: U.RectangleLayer(
        [
          [51.554488,-0.108964], // bottom left corner
          [51.555682,-0.107580], // top right corner
        ],
      ),
    );
  }
}