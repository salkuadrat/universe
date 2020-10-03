import 'package:flutter/rendering.dart';

import '../../../core/core.dart';
import '../../../shared.dart';
import '../tile.dart';

class DefaultTileProvider extends TileProvider {
  const DefaultTileProvider();
  
  _getZoomForUrl(Coordinate coordinate, TileLayerOptions options) {
    var zoom = coordinate.z;
    final maxZoom = options.maxZoom;
    final zoomReverse = options.zoomReverse;
    final zoomOffset = options.zoomOffset;

    if(zoomReverse) {
      zoom = maxZoom - zoom;
    }

    return zoom + zoomOffset;
  }

  @override
  String getTileUrl(Crs crs, Coordinate coordinate, TileLayerOptions options) {
    final templateUrl = options.wmsOptions != null 
      ? options.wmsOptions.getUrl(crs, coordinate, options.tileSize.width, options.retinaMode) 
      : options.templateUrl;
    
    final zoom = _getZoomForUrl(coordinate, options);
    final x = coordinate.x.round();
    final y = coordinate.y.round();
    final z = zoom.round();
    final invertY = ((1 << z) - 1) - y;

    final data = <String, String>{
      's': getSubdomain(coordinate, options),
      'x': x.toString(),
      'y': options.tms ? invertY.toString() : y.toString(),
      'z': z.toString(),
      'r': options.retinaMode ? '@2x' : '',
    }..addAll(options.additionalOptions);

    return urlFromTemplate(templateUrl, data);
  }

  @override
  ImageProvider getImage(Crs crs, Coordinate coordinate, TileLayerOptions options) => 
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
  void dispose() {

  }
}