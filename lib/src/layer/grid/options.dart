import 'package:flutter/rendering.dart';

import '../../shared.dart';
import '../layer.dart';

class GridLayerOptions extends LayerOptions {
   
  /// Size for the tile.
  /// Default is 256
  final double tileSize;

  // The minimum zoom level down to which this layer will be
  // displayed (inclusive).
  final double minZoom;

  /// The maximum zoom level up to which this layer will be
  /// displayed (inclusive).
  /// In most tile providers goes from 0 to 19.
  final double maxZoom;

  /// Minimum zoom number the tile source has available. If it is specified,
  /// the tiles on all zoom levels lower than minNativeZoom will be loaded
  /// from minNativeZoom level and auto-scaled.
  final double minNativeZoom;

  /// Maximum zoom number the tile source has available. If it is specified,
  /// the tiles on all zoom levels higher than maxNativeZoom will be loaded
  /// from maxNativeZoom level and auto-scaled.
  final double maxNativeZoom;

  /// If set to true, the zoom number used in tile URLs will be reversed (`maxZoom - zoom` instead of `zoom`)
  final bool zoomReverse;

  /// The zoom number used in tile URLs will be offset with this value.
  final double zoomOffset;

  /// When panning the map, keep this many rows and columns of tiles before
  /// unloading them.
  final int keepBuffer;

  /// Placeholder to show until tile images are fetched by the provider.
  final ImageProvider placeholderImage;

  /// Tile image to show in place of the tile that failed to load.
  final ImageProvider errorImage;

  /// Tiles will not update more than once every `updateInterval`
  /// (default 200 milliseconds) when panning.
  /// It can be null (but it will calculating for loading tiles every frame when panning / zooming, flutter is fast)
  /// This can save some fps and even bandwidth
  /// (ie. when fast panning / animating between long distances in short time)
  final Duration updateInterval;

  /// Tiles fade in duration in milliseconds (default 100),
  /// it can be null to avoid fade in
  final Duration tileFadeInDuration;

  /// Opacity start value when Tile starts fade in (0.0 - 1.0)
  /// Takes effect if `tileFadeInDuration` is not null
  final double tileFadeInStart;

  /// Opacity start value when an exists Tile starts fade in with different Url (0.0 - 1.0)
  /// Takes effect when `tileFadeInDuration` is not null and if `overrideTilesWhenUrlChanges` if true
  final double tileFadeInStartWhenOverride;

  /// `false`: current Tiles will be first dropped and then reload via new url (default)
  /// `true`: current Tiles will be visible until new ones aren't loaded (new Tiles are loaded independently)
  /// @see https://github.com/johnpryan/flutter_map/issues/583
  final bool overrideTilesWhenUrlChanges;

  /// If `true`, it will request four tiles of half the specified size and a
  /// bigger zoom level in place of one to utilize the high resolution.
  ///
  /// If `true` then MapOptions's `maxZoom` should be `maxZoom - 1` since retinaMode
  /// just simulates retina display by playing with `zoomOffset`.
  /// If geoserver supports retina `@2` tiles then it it advised to use them
  /// instead of simulating it (use {r} in the [urlTemplate])
  ///
  /// It is advised to use retinaMode if display supports it, write code like this:
  /// TileLayerOptions(
  ///     retinaMode: true && MediaQuery.of(context).devicePixelRatio > 1.0,
  /// ),
  final bool retinaMode;

  /// This callback will be execute if some errors by getting tile
  final Function(Tile, dynamic) onTileError;

  GridLayerOptions({
    num tileSize = tileSizeDef, 
    this.minZoom = minZoomDef, 
    this.maxZoom = maxZoomDef, 
    this.minNativeZoom, 
    this.maxNativeZoom, 
    this.zoomReverse = zoomReverseDef, 
    this.zoomOffset = zoomOffsetDef, 
    this.keepBuffer = keepBufferDef, 
    this.placeholderImage, 
    this.errorImage, 
    int updateInterval = updateTileIntervalDef, 
    int tileFadeInDuration = tileFadeInDurationDef, 
    this.tileFadeInStart = tileFadeInStartDef, 
    this.tileFadeInStartWhenOverride = tileFadeInStartWhenOverrideDef, 
    this.overrideTilesWhenUrlChanges = overrideTilesWhenUrlChangesDef, 
    this.retinaMode = retinaModeDef, 
    this.onTileError,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
  }) : 
    this.tileSize = tileSize?.toDouble() ?? tileSizeDef, 
    this.updateInterval = Duration(milliseconds: updateInterval),
    this.tileFadeInDuration = Duration(milliseconds: tileFadeInDuration),
    super(interactive: interactive, attribution: attribution);
}