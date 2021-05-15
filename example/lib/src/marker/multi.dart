import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class MultiMarkerMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      center: [51.555158, -0.108343],
      zoom: 16, 
      // multiple markers with default styles
      markers: U.MarkerLayer([
        [51.558374, -0.107398],
        [51.556674, -0.106215],
        [51.556669, -0.108123],
      ]),
    );
  }
}