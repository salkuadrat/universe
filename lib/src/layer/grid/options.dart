/* import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

import '../../core/core.dart';
import '../../shared.dart';
import '../layer.dart';

class GridLayerOptions extends InteractiveLayerOptions {
   
  /// Size for the tile.
  /// Default is 256 x 256
  final Size tileSize;

  /// If set, tiles will only be loaded inside the set `LatLngBounds`.
  final LatLngBounds bounds;

  /// The minimum zoom level down to which this layer 
  /// will be displayed (inclusive).
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

  /// Opacity of the tiles.
  final double opacity;

  /// If set to true, the zoom number used in tile URLs will be reversed 
  /// (`maxZoom - zoom` instead of `zoom`)
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

  /// By default, a smooth zoom animation (during a [touch zoom](#map-touchzoom) 
  /// or a [`flyTo()`](#map-flyto)) will update grid layers every integer zoom level. 
  /// 
  /// Setting this option to `false` will update the grid layer 
  /// only when the smooth animation ends.
	final bool updateWhenZooming;

  /// Tiles will not update more than once every `updateInterval`
  /// (default 200 milliseconds) when panning.
  /// It can be null (but it will calculating for loading tiles every frame when panning / zooming, flutter is fast)
  /// This can save some fps and even bandwidth
  /// (ie. when fast panning / animating between long distances in short time)
  final Duration updateInterval;

  /// Tiles fade in duration in milliseconds (default 100),
  /// it can be null to avoid fade in
  final Duration tileFadeInDuration;

  /// Tiles fade in curve.
  /// Default: Curves.easeInOut
  final Curve tileFadeInCurve;

  /// Opacity start value when Tile starts fade in (0.0 - 1.0)
  /// Takes effect if `tileFadeInDuration` is not null
  final double tileFadeInStart;

  /// Opacity start value when an exists Tile starts fade in with different Url (0.0 - 1.0)
  /// Takes effect when `tileFadeInDuration` is not null and if `overrideTilesWhenUrlChanges` if true
  final double tileFadeInStartWhenOverride;

  /// `false`: current Tiles will be first dropped and then reload via new url (default)
  /// `true`: current Tiles will be visible until new ones aren't loaded (new Tiles are loaded independently)
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
  ///   retinaMode: true && MediaQuery.of(context).devicePixelRatio > 1.0,
  /// )
  final bool retinaMode;

  /// This callback will be execute if some errors by getting tile
  final Function(Tile, dynamic) onTileError;

  bool get hasMinZoom => minZoom != null;
  bool get hasMaxZoom => maxZoom != null;
  bool get hasMinNativeZoom => minNativeZoom != null;
  bool get hasMaxNativeZoom => maxNativeZoom != null;

  bool get hasBounds => bounds != null;
  
  GridLayerOptions({
    num tileSize = tileSizeDef, 
    this.minZoom = minZoomDef, 
    this.maxZoom = maxZoomDef, 
    this.opacity = tileOpacityDef,
    this.minNativeZoom, 
    this.maxNativeZoom, 
    dynamic bounds,
    this.zoomReverse = zoomReverseDef, 
    this.zoomOffset = zoomOffsetDef, 
    this.keepBuffer = keepBufferDef, 
    this.placeholderImage, 
    this.errorImage, 
    this.updateWhenZooming = updateWhenZoomingDef,
    int updateInterval = updateTileIntervalDef, 
    int tileFadeInDuration = tileFadeInDurationDef, 
    this.tileFadeInCurve = tileFadeInCurveDef,
    this.tileFadeInStart = tileFadeInStartDef, 
    this.tileFadeInStartWhenOverride = tileFadeInStartWhenOverrideDef, 
    this.overrideTilesWhenUrlChanges = overrideTilesWhenUrlChangesDef, 
    this.retinaMode = retinaModeDef, 
    this.onTileError,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
    TapLayerCallback onTap,
    TapUpLayerCallback onTapUp,
    TapDownLayerCallback onTapDown,
    TapLayerCallback onTapCancel,
    TapLayerCallback onSecondaryTap,
    TapDownLayerCallback onSecondaryTapDown,
    TapUpLayerCallback onSecondaryTapUp,
    TapLayerCallback onSecondaryTapCancel,
    DoubleTapLayerCallback onDoubleTap,
    LongPressLayerCallback onLongPress,
    LongPressStartLayerCallback onLongPressStart,
    LongPressMoveUpdateLayerCallback onLongPressMoveUpdate,
    LongPressUpLayerCallback onLongPressUp,
    LongPressEndLayerCallback onLongPressEnd,
    LongPressLayerCallback onSecondaryLongPress,
    LongPressStartLayerCallback onSecondaryLongPressStart,
    LongPressMoveUpdateLayerCallback onSecondaryLongPressMoveUpdate,
    LongPressUpLayerCallback onSecondaryLongPressUp,
    LongPressEndLayerCallback onSecondaryLongPressEnd,
  }) : 
  this.tileSize = Size.from([tileSize ?? tileSizeDef, tileSize ?? tileSizeDef]), 
  this.bounds = bounds != null ? LatLngBounds.from(bounds) : null,
  this.updateInterval = Duration(milliseconds: updateInterval),
  this.tileFadeInDuration = Duration(milliseconds: tileFadeInDuration),
  super(
    interactive: interactive, 
    attribution: attribution,
    onTap: onTap,
    onTapUp: onTapUp,
    onTapDown: onTapDown,
    onTapCancel: onTapCancel,
    onSecondaryTap: onSecondaryTap,
    onSecondaryTapDown: onSecondaryTapDown,
    onSecondaryTapUp: onSecondaryTapUp,
    onSecondaryTapCancel: onSecondaryTapCancel,
    onDoubleTap: onDoubleTap,
    onLongPress: onLongPress,
    onLongPressStart: onLongPressStart,
    onLongPressMoveUpdate: onLongPressMoveUpdate,
    onLongPressUp: onLongPressUp,
    onLongPressEnd: onLongPressEnd,
    onSecondaryLongPress: onSecondaryLongPress,
    onSecondaryLongPressStart: onSecondaryLongPressStart,
    onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
    onSecondaryLongPressUp: onSecondaryLongPressUp,
    onSecondaryLongPressEnd: onSecondaryLongPressEnd,
  );

  GridLayerOptions copy({
    String templateUrl,
    dynamic subdomains,
    dynamic bounds,
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
    bool tms = tmsDef,
    Map<String, String> additionalOptions,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
    TapLayerCallback onTap,
    TapUpLayerCallback onTapUp,
    TapDownLayerCallback onTapDown,
    TapLayerCallback onTapCancel,
    TapLayerCallback onSecondaryTap,
    TapDownLayerCallback onSecondaryTapDown,
    TapUpLayerCallback onSecondaryTapUp,
    TapLayerCallback onSecondaryTapCancel,
    DoubleTapLayerCallback onDoubleTap,
    LongPressLayerCallback onLongPress,
    LongPressStartLayerCallback onLongPressStart,
    LongPressMoveUpdateLayerCallback onLongPressMoveUpdate,
    LongPressUpLayerCallback onLongPressUp,
    LongPressEndLayerCallback onLongPressEnd,
    LongPressLayerCallback onSecondaryLongPress,
    LongPressStartLayerCallback onSecondaryLongPressStart,
    LongPressMoveUpdateLayerCallback onSecondaryLongPressMoveUpdate,
    LongPressUpLayerCallback onSecondaryLongPressUp,
    LongPressEndLayerCallback onSecondaryLongPressEnd,
  }) {
    return GridLayerOptions(
      tileSize: tileSize ?? this.tileSize.width,
      bounds: bounds ?? this.bounds,
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
      onTapDown: onTapDown ?? this.onTapDown,
      onTapUp: onTapUp ?? this.onTapUp,
      onTap: onTap ?? this.onTap,
      onTapCancel: onTapCancel ?? this.onTapCancel,
      onSecondaryTap: onSecondaryTap ?? this.onSecondaryTap,
      onSecondaryTapDown: onSecondaryTapDown ?? this.onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp ?? this.onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel ?? this.onSecondaryTapCancel,
      onDoubleTap: onDoubleTap ?? this.onDoubleTap,
      onLongPress: onLongPress ?? this.onLongPress,
      onLongPressStart: onLongPressStart ?? this.onLongPressStart,
      onLongPressMoveUpdate: onLongPressMoveUpdate ?? this.onLongPressMoveUpdate,
      onLongPressUp: onLongPressUp ?? this.onLongPressUp,
      onLongPressEnd: onLongPressEnd ?? this.onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress ?? this.onSecondaryLongPress,
      onSecondaryLongPressStart: onSecondaryLongPressStart ?? this.onSecondaryLongPressStart,
      onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate ?? this.onSecondaryLongPressMoveUpdate,
      onSecondaryLongPressUp: onSecondaryLongPressUp ?? this.onSecondaryLongPressUp,
      onSecondaryLongPressEnd: onSecondaryLongPressEnd ?? this.onSecondaryLongPressEnd,
    );
  }
} */