import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class StaticMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      center: [51.555158, -0.108343],
      zoom: 15,
      interactive: false,
    );
  }
}
