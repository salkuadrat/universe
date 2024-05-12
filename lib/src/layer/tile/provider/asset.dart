import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';
import '../../layer.dart';

class AssetTileProvider extends DefaultTileProvider {
  const AssetTileProvider();

  @override
  ImageProvider getImage(String? templateUrl, Bounds? globalTileRange,
      Coordinate coordinate, TileLayerOptions? options) {
    String tileUrl =
        getTileUrl(templateUrl, globalTileRange, coordinate, options);
    return AssetImage(tileUrl);
  }
}
