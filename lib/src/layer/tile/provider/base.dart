import 'package:flutter/rendering.dart';

import '../../../core/geometry/coordinates.dart';
import '../options.dart';

abstract class TileProvider {
  const TileProvider();
  
  ImageProvider getImage(Coordinates coords, TileLayerOptions options);

  String getTileUrl(Coordinates coords, TileLayerOptions options);

  String getSubdomain(Coordinates coords, TileLayerOptions options);

  void dispose();
}