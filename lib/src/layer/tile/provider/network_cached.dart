import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';
import '../../layer.dart';

class CachedNetworkTileProvider extends DefaultTileProvider {
  const CachedNetworkTileProvider();

  @override
  ImageProvider getImage(String? templateUrl, Bounds? globalTileRange,
      Coordinate coordinate, TileLayerOptions? options) {
    return CachedNetworkImageProvider(
      getTileUrl(templateUrl, globalTileRange, coordinate, options),
      //cache: true,
      //retries: 4,
      //timeRetry: Duration(milliseconds: 200),
    );
  }
}
