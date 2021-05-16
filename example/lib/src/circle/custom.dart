import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class CustomCircleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      center: [-6.170039, 106.8241],
      zoom: 15,
      onReady: () => print('Map ready!'),
      // circle with custom styles
      circles: U.CircleLayer(
        [-6.170039, 106.8241],
        radius: 240,
        stroke: true,
        strokeColor: Colors.orange,
        strokeCap: StrokeCap.butt,
        strokeJoin: StrokeJoin.bevel,
        strokeWidth: 2.4,
        strokeOpacity: 0.8,
        fill: true,
        fillColor: Colors.pink,
        fillOpacity: 0.3,
      ),
    );
  }
}
