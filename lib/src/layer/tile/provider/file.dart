import 'dart:io';
import 'package:flutter/rendering.dart';

import '../../../core/core.dart';
import '../../layer.dart';

class FileTileProvider extends DefaultTileProvider {
  const FileTileProvider();

  @override
  ImageProvider getImage(Crs crs, Coordinate coordinate, TileLayerOptions options) {
    return FileImage(File(getTileUrl(crs, coordinate, options)));
  }
}