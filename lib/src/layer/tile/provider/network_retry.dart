import 'package:flutter/rendering.dart';
import 'package:flutter_image/network.dart';

import '../../../core/core.dart';
import '../../layer.dart';

class NetworkRetryTileProvider extends DefaultTileProvider {
  const NetworkRetryTileProvider();

  @override
  ImageProvider getImage(Crs crs, Coordinate coordinate, TileLayerOptions options) {
    return NetworkImageWithRetry(getTileUrl(crs, coordinate, options));
  }
}