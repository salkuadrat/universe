import 'package:flutter/rendering.dart';

import '../../../core/core.dart';
import '../../../shared.dart';
import '../tile.dart';

class DefaultTileProvider extends TileProvider {
  const DefaultTileProvider();
  
  _getZoomForUrl(Coordinate coordinate, TileLayerOptions options) {
    var zoom = coordinate.z;
    final maxZoom = options.maxZoom;
    final zoomReverse = options.zoomReverse!;
    final zoomOffset = options.zoomOffset!;

    if(zoomReverse) {
      zoom = maxZoom! - zoom;
    }

    return zoom + zoomOffset;
  }

  @override
  String getTileUrl(String? templateUrl, Bounds? globalTileRange, Coordinate coordinate, TileLayerOptions? options) {
    //final templateUrl = options.getTemplateUrl(crs, coordinate);
    final zoom = _getZoomForUrl(coordinate, options!);
    final x = coordinate.x.round();
    final y = coordinate.y.round();
    final z = zoom.round();
    final inverseY = globalTileRange!.max.y - y;

    Map<String, dynamic> data = <String, dynamic>{
      's': getSubdomain(coordinate, options),
      'x': x.toString(),
      'y': options.tms ? inverseY.toString() : y.toString(),
      'z': z.toString(),
      'r': options.retinaMode! ? '@2x' : '',
      '-y': inverseY.toString(),
    }..addAll(options.additionalOptions!);

    return urlFromTemplate(templateUrl!, data);
  }

  @override
  ImageProvider getImage(String? templateUrl, Bounds? globalTileRange, Coordinate coordinate, TileLayerOptions? options) => 
    throw UnimplementedError();

  @override
  String getSubdomain(Coordinate coordinate, TileLayerOptions options) {
    if(options.subdomains.isNotEmpty) {
      var index = (coordinate.x + coordinate.y).round() % options.subdomains.length;
      return options.subdomains[index];
    }
    return '';
  }

  @override
  void dispose() {}
}