import 'package:flutter/rendering.dart';

import '../../shared.dart';
import '../layer.dart';

class TileLayerOptions extends GridLayerOptions {

  /// Defines the structure to create the URLs for the tiles.
  /// `{s}` means one of the available subdomains (can be omitted)
  /// `{z}` zoom level
  /// `{x}` and `{y}` — tile coordinates
  /// `{r}` can be used to add "&commat;2x" to the URL to load retina tiles (can be omitted)
  ///
  /// Example:
  ///
  /// https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png
  ///
  /// Is translated to this:
  ///
  /// https://a.tile.openstreetmap.org/12/2177/1259.png
  final String templateUrl;
  
  final List<String> subdomains;

  final TileProvider tileProvider;

  final WMSTileLayerOptions wmsOptions;

  /// If `true`, inverses Y axis numbering for tiles (turn this on for
  /// [TMS](https://en.wikipedia.org/wiki/Tile_Map_Service) services).
  final bool tms;

  final Map<String, String> additionalOptions;

  TileLayerOptions({
    this.templateUrl,
    dynamic subdomains = 'abc',
    num tileSize = tileSizeDef, 
    double minZoom = minZoomDef, 
    double maxZoom = maxZoomDef, 
    double opacity = tileOpacityDef,
    double minNativeZoom, 
    double maxNativeZoom, 
    bool zoomReverse = zoomReverseDef, 
    double zoomOffset = zoomOffsetDef, 
    int keepBuffer = keepBufferDef, 
    ImageProvider placeholderImage, 
    ImageProvider errorImage, 
    int updateInterval = updateTileIntervalDef, 
    int tileFadeInDuration = tileFadeInDurationDef, 
    double tileFadeInStart = tileFadeInStartDef, 
    double tileFadeInStartWhenOverride = tileFadeInStartWhenOverrideDef, 
    bool overrideTilesWhenUrlChanges = overrideTilesWhenUrlChangesDef, 
    bool retinaMode = retinaModeDef, 
    Function(Tile, dynamic) onTileError,
    this.tileProvider = tileProviderDef,
    this.wmsOptions,
    this.tms = tmsDef,
    this.additionalOptions = const {},
    bool interactive = interactiveDef,
    String attribution = attributionDef,
  }) : this.subdomains = parseSubdomains(subdomains), super(
      tileSize: tileSize,
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
      onTileError: onTileError,
      interactive: interactive, 
      attribution: attribution,
    );

  TileLayerOptions copy({
    String templateUrl,
    dynamic subdomains,
    num tileSize, 
    double minZoom, 
    double maxZoom, 
    double opacity,
    double minNativeZoom, 
    double maxNativeZoom, 
    bool zoomReverse, 
    double zoomOffset, 
    int keepBuffer, 
    ImageProvider placeholderImage, 
    ImageProvider errorImage, 
    int updateInterval, 
    int tileFadeInDuration, 
    double tileFadeInStart, 
    double tileFadeInStartWhenOverride, 
    bool overrideTilesWhenUrlChanges, 
    bool retinaMode, 
    Function(Tile, dynamic) onTileError,
    TileProvider tileProvider,
    WMSTileLayerOptions wmsOptions,
    bool tms = tmsDef,
    Map<String, String> additionalOptions = const {},
    bool interactive = interactiveDef,
    String attribution = attributionDef,
  }) {
    return TileLayerOptions(
      templateUrl: templateUrl ?? this.templateUrl,
      subdomains: subdomains ?? this.subdomains,
      tileSize: tileSize ?? this.tileSize.width,
      minZoom: minZoom ?? this.minZoom,
      maxZoom: maxZoom ?? this.maxZoom,
      opacity: opacity ?? this.opacity,
      minNativeZoom: minNativeZoom ?? this.minNativeZoom,
      maxNativeZoom: maxNativeZoom ?? this.maxNativeZoom,
      zoomReverse: zoomReverse ?? this.zoomReverse,
      zoomOffset: zoomOffset ?? this.zoomOffset,
      keepBuffer: keepBuffer ?? this.keepBuffer,
      placeholderImage: placeholderImage ?? this.placeholderImage,
      errorImage: errorImage ?? this.errorImage,
      updateInterval: updateInterval ?? this.updateInterval.inMilliseconds,
      tileFadeInDuration: tileFadeInDuration ?? this.tileFadeInDuration.inMilliseconds,
      tileFadeInStart: tileFadeInStart ?? this.tileFadeInStart,
      tileFadeInStartWhenOverride: tileFadeInStartWhenOverride ?? this.tileFadeInStartWhenOverride,
      overrideTilesWhenUrlChanges: overrideTilesWhenUrlChanges ?? this.overrideTilesWhenUrlChanges,
      retinaMode: retinaMode ?? this.retinaMode,
      onTileError: onTileError ?? this.onTileError,
      interactive: interactive ?? this.interactive, 
      attribution: attribution ?? this.attribution,
    );
  }
}