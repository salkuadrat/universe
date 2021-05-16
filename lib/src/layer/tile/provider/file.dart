import 'dart:io';
import 'package:flutter/rendering.dart';

import '../../../core/core.dart';
import '../../layer.dart';

class FileTileProvider extends DefaultTileProvider {
  const FileTileProvider();

  @override
  ImageProvider getImage(String? templateUrl, Bounds? globalTileRange,
      Coordinate coordinate, TileLayerOptions? options) {
    return FileImage(
        File(getTileUrl(templateUrl, globalTileRange, coordinate, options)));
  }
}
