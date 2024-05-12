import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class CachedNetworkTileMap extends StatelessWidget {
  const CachedNetworkTileMap({super.key});

  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [51.555015, -0.108331],
      zoom: 16,
      options: TileLayerOptions(
        tileProvider: const CachedNetworkTileProvider(),
      ),
    );
  }
}
