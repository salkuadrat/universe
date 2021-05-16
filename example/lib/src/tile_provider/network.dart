import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class NetworkTileMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      center: [51.555015, -0.108331],
      zoom: 16,
      options: TileLayerOptions(
        tileProvider: NetworkTileProvider(),
      ),
    );
  }
}
