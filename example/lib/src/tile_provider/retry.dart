import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class NetworkRetryTileMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555015, -0.108331],
      zoom: 16,
      options: TileLayerOptions(
        tileProvider: NetworkRetryTileProvider(),
      ),
    );
  }
}
