import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class CustomCompassMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      center: [51.555158, -0.108343],
      zoom: 15, 
      showLocator: true,
      onReady: () => print('Map is ready!'),
      compass: Compass(
        icon: Icon(Icons.arrow_upward, size: 28, color: Colors.orange),
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(bottom: 30, right: 90),
      ),
    );
  }
}