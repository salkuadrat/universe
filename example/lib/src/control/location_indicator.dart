import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class CustomLocationIndicatorMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      center: [51.555158, -0.108343],
      zoom: 15, 
      live: true,
      showLocator: true,
      onReady: () => print('Map is ready!'),
      locationIndicator: LocationIndicator(
        radius: 20,
        overlayRadius: 150,
        color: Colors.red,
      ),
    );
  }
}