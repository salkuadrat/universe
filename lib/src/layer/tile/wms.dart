import 'package:flutter/foundation.dart';

import '../../core/core.dart';

class WMSTileLayerOptions {

  final service = 'WMS';
  final request = 'GetMap';

  /// url of WMS service.
  /// 'http://ows.mundialis.de/services/service?'
  final String baseUrl;

  /// list of WMS layers to show
  final List<String> layers;

  /// list of WMS styles
  final List<String> styles;

  /// WMS image format (use 'image/png' for layers with transparency)
  final String format;

  /// Version of the WMS service to use
  final String version;

  /// tile transperency flag
  final bool transparent;

  /// other request parameters
  final Map<String, String> otherParameters;

  double versionNumber;
  
  WMSTileLayerOptions({
    @required this.baseUrl,
    this.layers = const [],
    this.styles = const [],
    this.format = 'image/png',
    this.version = '1.1.1',
    this.transparent = true,
    this.otherParameters = const {},
  }) {
    versionNumber = double.tryParse(version.split('.').take(2).join('.')) ?? 0;
  }

  String encodedBaseUrl(Crs crs) {
    final projectionKey = versionNumber >= 1.3 ? 'crs' : 'srs';
    final buffer = StringBuffer(baseUrl)
      ..write('&service=$service')
      ..write('&request=$request')
      ..write('&layers=${layers.map(Uri.encodeComponent).join(',')}')
      ..write('&styles=${styles.map(Uri.encodeComponent).join(',')}')
      ..write('&format=${Uri.encodeComponent(format)}')
      ..write('&$projectionKey=${Uri.encodeComponent(crs.code)}')
      ..write('&version=${Uri.encodeComponent(version)}')
      ..write('&transparent=$transparent');
    
    otherParameters.forEach((k, v) => buffer.write('&$k=${Uri.encodeComponent(v)}'));
    return buffer.toString();
  }

  String getUrl(Crs crs, Coordinate coordinate, num tileSize, bool retinaMode) {
    final tileSizePoint = UPoint(tileSize.toDouble(), tileSize.toDouble());

    final nwPoint = coordinate.scaleBy(tileSizePoint);
    final sePoint = nwPoint + tileSizePoint;

    final nwLatLng = crs.pointToLatLng(UPoint.from(nwPoint), coordinate.z);
    final seLatLng = crs.pointToLatLng(UPoint.from(sePoint), coordinate.z);

    final nw = crs.project(nwLatLng);
    final se = crs.project(seLatLng);

    final bounds = Bounds(nw, se);

    final bbox = (versionNumber >= 1.3 && crs is Epsg4326)
        ? [bounds.min.y, bounds.min.x, bounds.max.y, bounds.max.x]
        : [bounds.min.x, bounds.min.y, bounds.max.x, bounds.max.y];
    
    final buffer = StringBuffer(encodedBaseUrl(crs));
    buffer.write('&width=${retinaMode ? tileSize * 2 : tileSize}');
    buffer.write('&height=${retinaMode ? tileSize * 2 : tileSize}');
    buffer.write('&bbox=${bbox.join(',')}');

    return buffer.toString();
  }
}