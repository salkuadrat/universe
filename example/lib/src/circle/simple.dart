import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class CircleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      center: [-6.170039, 106.8241],
      zoom: 15,
      onReady: () => print('Map ready!'),
      // by default, CircleLayer will use style from theme primaryColor
      circles: U.CircleLayer(
        [-6.170039, 106.8241],
        radius: 160,
      ),
    );
  }
}
