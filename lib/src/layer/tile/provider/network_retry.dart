import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image/flutter_image.dart';

import '../../../core/core.dart';
import '../../layer.dart';

class NetworkRetryTileProvider extends DefaultTileProvider {
  const NetworkRetryTileProvider();

  @override
  ImageProvider getImage(String? templateUrl, Bounds? globalTileRange,
      Coordinate coordinate, TileLayerOptions? options) {
    return NetworkImageWithRetry(
        getTileUrl(templateUrl, globalTileRange, coordinate, options));
  }
}
