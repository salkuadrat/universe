import 'package:flutter/rendering.dart';

import '../../../core/core.dart';
import '../../layer.dart';

class AssetTileProvider extends DefaultTileProvider {
  const AssetTileProvider();
  
  @override
  ImageProvider getImage(Crs crs, Coordinate coordinate, TileLayerOptions options) {
    return AssetImage(getTileUrl(crs, coordinate, options));
  }
}