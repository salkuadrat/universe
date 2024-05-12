import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class MultiLayerMap extends StatelessWidget {
  const MultiLayerMap({super.key});

  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      type: MapBoxType.Bright,
      center: [48.858236, 2.294477],
      zoom: 13,
      tiles: [
        // add environmental measurements map layer from SafeCast (http://safecast.org/)
        U.TileLayer(
          'https://s3.amazonaws.com/te512.safecast.org/{z}/{x}/{y}.png',
          attribution:
              'Data: &copy; OpenStreetMap contributors | Style: &copy; SafeCast',
          maxZoom: 16,
        ),
        // add map layer from OpenRailwayMap
        U.TileLayer(
          'https://{s}.tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png',
          attribution:
              'Data: &copy; OpenStreetMap contributors | Style: &copy; OpenRailwayMap',
          maxZoom: 19,
        ),
      ],
    );
  }
}
