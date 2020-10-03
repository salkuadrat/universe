import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';

import '../../../core/core.dart';
import '../../layer.dart';

class CachedNetworkTileProvider extends DefaultTileProvider {
  const CachedNetworkTileProvider();
  
  @override
  ImageProvider getImage(Crs crs, Coordinate coordinate, TileLayerOptions options) {
    return CachedNetworkImageProvider(getTileUrl(crs, coordinate, options));
  }
}