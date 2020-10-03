import 'package:flutter/rendering.dart';

import '../../../core/core.dart';
import '../../layer.dart';

class NetworkTileProvider extends DefaultTileProvider {
  const NetworkTileProvider();
  
  @override
  ImageProvider getImage(Crs crs, Coordinate coordinate, TileLayerOptions options) {
    return NetworkImage(getTileUrl(crs, coordinate, options));
  }
}