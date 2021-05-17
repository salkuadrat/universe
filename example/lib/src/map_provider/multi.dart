import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class MultiLayerMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      type: OpenStreetMapType.HOT,
      center: [48.858236, 2.294477],
      zoom: 12,
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
