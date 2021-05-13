import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class FitBoundsMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      type: MapBoxType.Bright,
      accessToken: yourAccessTokenHere,
      center: [51.555158, -0.108343],
      zoom: 16,
      fitBounds: LatLngBounds(
        [51.293714,-0.527292], // southWest bound
        [51.669162,0.256857],  // northEast bound
      ),
    );
  }
}