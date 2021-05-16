import 'package:flutter/rendering.dart';

import '../../../core/core.dart';
import '../../../network/network.dart';
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
