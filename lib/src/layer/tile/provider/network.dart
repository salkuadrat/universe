import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';
import '../../layer.dart';

class NetworkTileProvider extends DefaultTileProvider {
  const NetworkTileProvider();

  @override
  ImageProvider getImage(String? templateUrl, Bounds? globalTileRange,
      Coordinate coordinate, TileLayerOptions? options) {
    return NetworkImage(
        getTileUrl(templateUrl, globalTileRange, coordinate, options));
  }
}
