import 'package:flutter/rendering.dart';

import '../../shared.dart';
import '../layer.dart';

class TileLayerOptions extends GridLayerOptions {

  final String templateUrl;
  final List<String> subdomains;

  TileLayerOptions({
    this.templateUrl,
    dynamic subdomains,
    num tileSize = tileSizeDef, 
    double minZoom = minZoomDef, 
    double maxZoom = maxZoomDef, 
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
    bool interactive = interactiveDef,
    String attribution = attributionDef,
  }) : this.subdomains = parseSubdomains(subdomains), super(
      tileSize: tileSize,
      minZoom: minZoom,
      maxZoom: maxZoom,
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
}