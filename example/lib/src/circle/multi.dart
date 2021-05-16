import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class MultiCircleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      center: [-6.175329, 106.827253],
      zoom: 15,
      onReady: () => print('Map ready!'),
      // multiple circle with the same style and radius
      // default circle style will use color from theme primaryColor
      circles: U.CircleLayer(
        [
          [-6.170039, 106.8241],
          [-6.181552, 106.826938],
          [-6.176160, 106.821770],
        ],
        radius: 160,
      ),
    );
  }
}
