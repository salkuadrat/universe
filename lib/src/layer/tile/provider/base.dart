import 'package:flutter/rendering.dart';

import '../../../core/core.dart';
import '../options.dart';

abstract class TileProvider {
  const TileProvider();
  
  ImageProvider getImage(String? templateUrl, Bounds? globalTileRange, Coordinate coordinate, TileLayerOptions? options);

  String getTileUrl(String? templateUrl, Bounds? globalTileRange, Coordinate coordinate, TileLayerOptions? options);

  String getSubdomain(Coordinate coordinate, TileLayerOptions options);

  void dispose();
}