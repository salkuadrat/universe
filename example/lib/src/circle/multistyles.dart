import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class MultiCircleStylesMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      center: [-6.175329, 106.827253],
      zoom: 15,
      onReady: () => print('Map ready!'),
      // multiple circles with different styles
      circles: U.CircleLayer(
        [
          // this circle will use default style from theme primaryColor
          U.Circle(
            [-6.170039, 106.8241],
            radius: 120,
          ),
          U.Circle(
            [-6.181552, 106.826938],
            radius: 150,
            strokeColor: Colors.red,
            strokeWidth: 0.8,
            fillColor: Colors.redAccent,
            fillOpacity: 0.4,
          ),
          U.Circle(
            [-6.176160, 106.821770],
            radius: 180,
            stroke: false,
            fillColor: Colors.orange,
          ),
        ],
        // this styles will be applied to all 3 circles
        strokeCap: StrokeCap.butt,
        strokeJoin: StrokeJoin.bevel,
      ),
    );
  }
}
