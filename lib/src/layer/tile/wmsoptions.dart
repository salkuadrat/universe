import 'package:flutter/widgets.dart';

import '../../core/core.dart';
import '../../shared.dart';
import '../layer.dart';

class WMSTileLayerOptions extends TileLayerOptions {
  final service = 'WMS';
  final request = 'GetMap';

  /// Coordinate Reference System to use for the WMS requests, defaults to map CRS.
  /// Don't change this if you're not sure what it means.
  final Crs? crs;

  /// List of WMS layers to show.
  final List<String> layers;

  /// list of WMS styles
  final List<String> styles;

  /// WMS image format (use `'image/png'` for layers with transparency).
  final String format;

  /// If `true`, the WMS service will return images with transparency.
  final bool transparent;

  /// If `true`, WMS request parameter keys will be uppercase.
  final bool uppercase;

  /// Version of the WMS service to use
  final String version;

  double get versionNumber =>
      double.tryParse(version.split('.').take(2).join('.')) ?? 0;

  WMSTileLayerOptions({
    String? templateUrl,
    dynamic subdomains,
    dynamic bounds,
    num? tileSize,
    double? minZoom,
    double? maxZoom,
    double? opacity,
    double? minNativeZoom,
    double? maxNativeZoom,
    bool? zoomReverse,
    double? zoomOffset,
    int? keepBuffer,
    ImageProvider? placeholderImage,
    ImageProvider? errorImage,
    required int updateInterval,
    required int tileFadeInDuration,
    double? tileFadeInStart,
    double? tileFadeInStartWhenOverride,
    bool? overrideTilesWhenUrlChanges,
    bool? retinaMode,
    Function(Tile, dynamic)? onTileError,
    TileProvider? tileProvider,
    bool tms = tmsDef,
    Map<String, dynamic> additionalOptions = const <String, dynamic>{},
    bool interactive = interactiveDef,
    String attribution = attributionDef,
    this.crs,
    dynamic layers = '',
    dynamic styles = '',
    this.format = 'image/jpeg',
    this.version = '1.1.1',
    this.transparent = false,
    this.uppercase = false,
  })  : assert(layers is String || layers is List<String>),
        assert(styles is String || styles is List<String>),
        this.layers = layers is String ? layers.split(',') : layers,
        this.styles = styles is String ? styles.split(',') : styles,
        super(
          templateUrl: templateUrl,
          subdomains: subdomains,
          tileSize: tileSize,
          bounds: bounds,
          minZoom: minZoom,
          maxZoom: maxZoom,
          opacity: opacity,
          minNativeZoom: minNativeZoom,
          maxNativeZoom: maxNativeZoom,
          zoomReverse: zoomReverse,
          zoomOffset: zoomOffset,
          keepBuffer: keepBuffer,
          placeholderImage: placeholderImage,
          errorImage: errorImage,
          updateInterval: updateInterval,
          tileFadeInDuration: tileFadeInDuration,
          tileFadeInStart: tileFadeInStart,
          tileFadeInStartWhenOverride: tileFadeInStartWhenOverride,
          overrideTilesWhenUrlChanges: overrideTilesWhenUrlChanges,
          retinaMode: retinaMode,
          tileProvider: tileProvider,
          onTileError: onTileError,
          interactive: interactive,
          attribution: attribution,
          additionalOptions: additionalOptions,
          tms: tms,
        );

  @override
  String getBaseUrl(Crs crs) => _baseUrl(crs);

  String get projection => versionNumber >= 1.3 ? 'crs' : 'srs';
  String get paramWidth => uppercase ? 'width'.toUpperCase() : 'width';
  String get paramHeight => uppercase ? 'height'.toUpperCase() : 'height';
  String get paramBbox => uppercase ? 'bbox'.toUpperCase() : 'bbox';
  String get paramService => uppercase ? 'service'.toUpperCase() : 'service';
  String get paramRequest => uppercase ? 'request'.toUpperCase() : 'request';
  String get paramLayers => uppercase ? 'layers'.toUpperCase() : 'layers';
  String get paramStyles => uppercase ? 'styles'.toUpperCase() : 'styles';
  String get paramFormat => uppercase ? 'format'.toUpperCase() : 'format';
  String get paramProjection =>
      uppercase ? projection.toUpperCase() : projection;
  String get paramVersion => uppercase ? 'version'.toUpperCase() : 'version';
  String get paramTransparent =>
      uppercase ? 'transparent'.toUpperCase() : 'transparent';

  @override
  String getTemplateUrl(Crs mapCrs, Coordinate? coordinate) {
    final crs = this.crs ?? mapCrs;
    final tileWidth = tileSize.width.toInt();
    final tileHeight = tileSize.height.toInt();
    final tileSizePoint = UPoint(
      tileWidth.toDouble(),
      tileHeight.toDouble(),
    );

    final nwPoint = coordinate!.scaleBy(tileSizePoint);
    final sePoint = nwPoint + tileSizePoint;

    final nwLatLng = crs.pointToLatLng(UPoint.from(nwPoint), coordinate.z);
    final seLatLng = crs.pointToLatLng(UPoint.from(sePoint), coordinate.z);

    final nw = crs.project(nwLatLng);
    final se = crs.project(seLatLng);

    final bounds = Bounds(nw, se);

    final bbox = (versionNumber >= 1.3 && crs is Epsg4326)
        ? [bounds.min.y, bounds.min.x, bounds.max.y, bounds.max.x]
        : [bounds.min.x, bounds.min.y, bounds.max.x, bounds.max.y];

    final buffer = StringBuffer(_baseUrl(crs));
    buffer.write('&$paramWidth=${isRetinaMode ? tileWidth * 2 : tileWidth}');
    buffer.write('&$paramHeight=${isRetinaMode ? tileHeight * 2 : tileHeight}');
    buffer.write('&$paramBbox=${bbox.join(',')}');

    return buffer.toString();
  }

  String _baseUrl(Crs crs) {
    final buffer = StringBuffer(templateUrl!)
      ..write('&$paramService=$service')
      ..write('&$paramRequest=$request')
      ..write('&$paramLayers=${layers.map(Uri.encodeComponent).join(',')}')
      ..write('&$paramStyles=${styles.map(Uri.encodeComponent).join(',')}')
      ..write('&$paramFormat=${Uri.encodeComponent(format)}')
      ..write('&$paramProjection=${Uri.encodeComponent(crs.code)}')
      ..write('&$paramVersion=${Uri.encodeComponent(version)}')
      ..write('&$paramTransparent=$transparent');

    additionalOptions?.forEach((key, value) {
      key = uppercase ? key.toUpperCase() : key;
      buffer.write('&$key=${Uri.encodeComponent(value.toString())}');
    });

    return buffer.toString();
  }
}
