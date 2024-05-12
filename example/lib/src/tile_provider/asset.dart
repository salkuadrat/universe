import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class AssetTileMap extends StatelessWidget {
  const AssetTileMap({super.key});

  @override
  Widget build(BuildContext context) {
    return U.Map(
      center: [56.704173, 11.543808],
      minZoom: 12,
      maxZoom: 14,
      zoom: 13,
      showLocator: false,
      maxBounds: LatLngBounds([
        [56.6877, 11.5089],
        [56.7378, 11.6644]
      ]),
      base: U.TileLayer(
        'assets/map/anholt_osmbright/{z}/{x}/{y}.png',
        maxZoom: 14,
        tileProvider: const AssetTileProvider(),
      ),
    );
  }
}
