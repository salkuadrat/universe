import 'package:flutter/rendering.dart';

import '../../../core/core.dart';
import '../options.dart';

abstract class TileProvider {
  const TileProvider();
  
  ImageProvider getImage(Crs crs, Coordinate coordinate, TileLayerOptions options);

  String getTileUrl(Crs crs, Coordinate coordinate, TileLayerOptions options);

  String getSubdomain(Coordinate coordinate, TileLayerOptions options);

  void dispose();
}