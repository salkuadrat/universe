import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';
import '../../layer.dart';

class CachedNetworkTileProvider extends DefaultTileProvider {
  const CachedNetworkTileProvider();

  @override
  ImageProvider getImage(String? templateUrl, Bounds? globalTileRange,
      Coordinate coordinate, TileLayerOptions? options) {
    return ExtendedNetworkImageProvider(
      getTileUrl(templateUrl, globalTileRange, coordinate, options),
      cache: true,
      retries: 4,
      timeRetry: Duration(milliseconds: 200),
    );
  }
}
