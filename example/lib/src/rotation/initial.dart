import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class InitialRotationMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      type: MapBoxType.Bright,
      accessToken: yourAccessTokenHere,
      center: [51.555158, -0.108343],
      zoom: 16,
      rotation: 72,
    );
  }
}
