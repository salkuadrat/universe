import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../core/core.dart';
import '../../log.dart';
import '../../map/map.dart';
import '../../shared.dart';
import '../layer.dart';

/// Used to load and display tile layers on the map.
///
/// Example:
///
/// ```dart
/// TileLayer(
///   options: TileLayerOptions(
///     templateUrl: 'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
///     subdomains: ['mt0','mt1','mt2','mt3'],
///     attribution: 'Map Data &copy; Google',
///     updateInterval: 100,
///     maxZoom: 20,
///     minZoom: 0,
///   ),
/// )
/// ```
///
/// Alias: U.TileLayer
///
/// Example:
///
/// ```dart
/// U.TileLayer(
///   templateUrl: 'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
///   subdomains: ['mt0','mt1','mt2','mt3'],
///   attribution: 'Map Data &copy; Google',
///   updateInterval: 100,
///   maxZoom: 20,
///   minZoom: 0,
/// )
/// ```
class TileLayer extends StatefulWidget {
  final TileLayerOptions options;

  const TileLayer({
    Key? key,
    required this.options,
  }) : super(key: key);

  @override
  _TileLayerState createState() => _TileLayerState();
}

class _TileLayerState extends State<TileLayer> with TickerProviderStateMixin {
  MapState get map => context.read<MapState>();
  MapController get controller => map.controller;
  TileLayerOptions get options => widget.options;

  Crs get crs => map.options.crs;
  Tuple2<double, double>? get latBounds => crs.latBounds;
  Tuple2<double, double>? get lngBounds => crs.lngBounds;

  Size get tileSize => options.tileSize;
  double? get minZoom => options.minZoom;
  double? get maxZoom => options.maxZoom;

  Map<String, Tile> _tiles = <String, Tile>{};
  Map<double, Level> _levels = <double, Level>{};

  Level? _level;
  double? _tileZoom;
  Bounds? _globalTileRange;
  List<double>? _xBounds;
  List<double>? _yBounds;

  int _lastUpdated = 0;
  StreamController<LatLng?>? _softUpdateStream;

  /// return false if there's unloaded tile
  /// return true if all tiles are already loaded
  bool get _isAllTilesLoaded {
    for (var entry in _tiles.entries) {
      if (entry.value.isNotLoaded) {
        return false;
      }
    }
    return true;
  }

  /// alias of _isAllTilesLoaded
  bool get _noTilesToLoad => _isAllTilesLoaded;

  @override
  void initState() {
    log('TileLayer initState');
    super.initState();

    _refresh();
    _initSoftUpdate();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      map.addChangedListener(_onMapChanged);
    });
  }

  bool get _hasUpdateStream => _softUpdateStream != null;
  bool get _canUpdate => _now - _lastUpdated > _updateInterval;

  int get _updateInterval => options.updateInterval.inMilliseconds;
  int get _now => DateTime.now().millisecondsSinceEpoch;

  /// Soft update will limit the process of updating tile to
  /// follow [updateTileInverval] options.
  ///
  /// For example: if updateTileInterval set to 200, it will only load new tile
  /// for no more than 200ms.
  ///
  _initSoftUpdate() {
    log('TileLayer initSoftUpdate');
    _softUpdateStream?.close();

    _softUpdateStream = StreamController<LatLng?>(sync: true);
    _softUpdateStream!.stream.listen((center) {
      if (_canUpdate) {
        log('TileLayer: Soft Updating...');
        _update(map.center);
        //_setZoomTransforms(map.center, map.zoom);
        _lastUpdated = _now;
      }
    });
  }

  /// soft update the tiles
  void _softUpdate() {
    log('TileLayer softUpdate');
    if (_hasUpdateStream) {
      _softUpdateStream?.add(map.center);
    } else {
      _update();
      _setZoomTransforms(map.center, map.zoom);
    }
  }

  @override
  void didUpdateWidget(TileLayer old) {
    super.didUpdateWidget(old);

    log('TileLayer didUpdateWidget');
    bool isReloadTiles = false;

    if (old.options.tileSize != options.tileSize) {
      isReloadTiles = true;
    }

    if (old.options.retinaMode != options.retinaMode) {
      isReloadTiles = true;
    }

    if (old.options.updateInterval != options.updateInterval) {
      _initSoftUpdate();
    }

    if (old.options.templateUrl != options.templateUrl && !isReloadTiles) {
      if (options.overrideTilesWhenUrlChanges!) {
        _tiles.forEach((_, tile) {
          tile.loadImageWith(options.tileProvider!.getImage(
            options.getTemplateUrl(crs, tile.coordinate),
            _globalTileRange,
            _wrap(tile.coordinate!),
            options,
          ));
        });
      } else {
        isReloadTiles = true;
      }
    }

    if (isReloadTiles) {
      _removeAllTiles();
      _refresh();
      _update();
    }
  }

  @override
  void dispose() {
    log('TileLayer dispose');
    //_removeAllTiles();
    _softUpdateStream?.close();
    options.tileProvider?.dispose();
    super.dispose();
  }

  Widget _tile(Tile tile) {
    final level = tile.level!;
    final scale = level.scale;

    final position = (tile.position! * scale) + level.translate;
    final width = tileSize.width * scale;
    final height = tileSize.height * scale;

    return Positioned(
      key: ValueKey(tile.key),
      top: position.y,
      left: position.x,
      width: width,
      height: height,
      child: TileImage(
        tile: tile,
        errorImage: options.errorImage,
      ),
    );
  }

  List<Widget> get _children {
    final tiles = _tiles.values.toList()..sort();

    return <Widget>[
      for (Tile tile in tiles) _tile(tile),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapState>(
      builder: (_, map, __) {
        return Stack(children: _children);
      },
    );
  }

  void _onMapChanged() {
    log('TileLayer onMapChanged');

    double zoom = _clampZoom(map.zoom);

    bool tooSmall = options.hasMinZoom && (zoom < options.minZoom!);
    bool tooBig = options.hasMaxZoom && (zoom > options.maxZoom!);

    if (tooSmall) zoom = options.minZoom!;
    if (tooBig) zoom = options.maxZoom!;

    if (_tileZoom == null) {
      if (mounted)
        setState(() {
          _tileZoom = zoom;
          _refresh(map.center, zoom);
          _setZoomTransforms(map.center, zoom);
        });
    }
    // refresh map if it's zoomed
    else if ((zoom - _tileZoom!).abs() > 0.75) {
      if (mounted)
        setState(() {
          _refresh(map.center, zoom);
          _update();
          _setZoomTransforms(map.center, zoom);
        });
    }
    // only update map if it's moved (change center)
    else {
      if (mounted)
        setState(() {
          // update map softly, based on tileUpdateInterval (default 200ms)
          _softUpdate();
          //_update();
          _setZoomTransforms(map.center, map.zoom);
        });
    }
  }

  void _resetGrid() {
    log('TileLayer resetGrid');

    final tileZoom = _tileZoom;
    final bounds = map.getPixelWorldBounds(tileZoom);

    if (bounds != null) {
      _globalTileRange = _pixelBoundsToTileRange(bounds);
    }

    if (lngBounds != null) {
      final minLng = math.min(lngBounds!.item1, lngBounds!.item2);
      final maxLng = math.max(lngBounds!.item1, lngBounds!.item2);

      _xBounds = [
        (map.project(LatLng(0, minLng), tileZoom).x / tileSize.x)
            .floorToDouble(),
        (map.project(LatLng(0, maxLng), tileZoom).x / tileSize.y)
            .ceilToDouble(),
      ];
    }

    if (latBounds != null) {
      final minLat = math.min(lngBounds!.item1, lngBounds!.item2);
      final maxLat = math.max(lngBounds!.item1, lngBounds!.item2);

      _yBounds = [
        (map.project(LatLng(minLat, 0), tileZoom).y / tileSize.x)
            .floorToDouble(),
        (map.project(LatLng(maxLat, 0), tileZoom).y / tileSize.y)
            .ceilToDouble(),
      ];
    }
  }

  Coordinate _wrap(Coordinate coordinate) {
    return Coordinate(
      _xBounds is List && _xBounds!.length == 2
          ? wrap(coordinate.x, _xBounds)
          : coordinate.x,
      _yBounds is List && _yBounds!.length == 2
          ? wrap(coordinate.y, _yBounds)
          : coordinate.y,
      coordinate.z,
    );
  }

  Bounds _pixelBoundsToTileRange(Bounds bounds) {
    return Bounds(
      bounds.min.unscaleBy(tileSize).floor(),
      bounds.max.unscaleBy(tileSize).ceil() - UPoint(1, 1),
    );
  }

  void _update([LatLng? center]) {
    if (_tileZoom == null) {
      return;
    }

    center ??= map.center;

    log('TileLayer Update $center $_tileZoom');

    final zoom = _clampZoom(map.zoom);
    final margin = options.keepBuffer!.toDouble();
    final pixelBounds = map.getPixelBounds(center, _tileZoom!);
    final tileRange = _pixelBoundsToTileRange(pixelBounds);
    final tileCenter = tileRange.center;

    Bounds noPruneRange = Bounds(
      tileRange.bottomLeft - UPoint(margin, -margin),
      tileRange.topRight + UPoint(margin, -margin),
    );

    bool isFinite = (tileRange.min.x != double.negativeInfinity) &&
        (tileRange.min.y != double.negativeInfinity) &&
        (tileRange.max.x != double.infinity) &&
        (tileRange.max.y != double.infinity);

    // Sanity check: panic if the tile range contains Infinity somewhere.
    if (!isFinite) {
      return;
    }

    _tiles.forEach((key, tile) {
      final c = tile.coordinate!;

      if (c.z != _tileZoom || !noPruneRange.contains(UPoint(c.x, c.y))) {
        _tiles[key]!.isCurrent = false;
      }
    });

    // _update just loads more tiles.
    // If the tile zoom level differs too much from the map's,
    // let _refresh reset levels and prune old tiles.
    if ((zoom - _tileZoom!).abs() > 0.75) {
      _refresh(center, zoom);
      return;
    }

    List<Coordinate> coordinates = [];

    int minY = tileRange.min.y.round();
    int maxY = tileRange.max.y.round();
    int minX = tileRange.min.x.round();
    int maxX = tileRange.max.x.round();

    // create a queue of coordinates to load tiles from
    for (int j = minY; j <= maxY; j++) {
      for (int i = minX; i <= maxX; i++) {
        final coordinate = Coordinate(i, j, _tileZoom!);
        final key = coordinate.key;

        if (_isValid(coordinate)) {
          // update tile if already exists or add coordinate to create tile
          _tiles.containsKey(key)
              ? _tiles[key]!.isCurrent = true
              : coordinates.add(coordinate);
        }
      }
    }

    // sort tile queue to load tiles in order of their distance to center
    coordinates.sort((a, b) =>
        (a.distanceTo(tileCenter) - b.distanceTo(tileCenter)).round());

    coordinates.forEach((coordinate) {
      _addTile(coordinate);
    });
  }

  void _refresh(
      [LatLng? center,
      double? zoom,
      bool isPrune = true,
      bool isUpdate = true]) {
    log('TileLayer Refresh');

    center ??= map.center;
    zoom ??= map.zoom;

    double tileZoom = _clampZoom(zoom.roundToDouble());

    bool tooBig = options.hasMaxZoom && (tileZoom > options.maxZoom!);
    bool tooSmall = options.hasMinZoom && (tileZoom < options.minZoom!);

    if (tooSmall) tileZoom = options.minZoom!;
    if (tooBig) tileZoom = options.maxZoom!;

    _tileZoom = tileZoom;

    _stopLoading();
    _updateLevels();
    _resetGrid();

    if (isUpdate) {
      _update(center);
    }

    if (isPrune) {
      _pruneTiles();
    }

    _setZoomTransforms(center, zoom);
  }

  void _stopLoading() {
    log('TileLayer stopLoading');

    List<String> toRemove = [];

    _tiles.forEach((key, tile) {
      if (tile.coordinate!.z != _tileZoom && tile.isNotLoaded) {
        toRemove.add(key);
      }
    });

    for (String key in toRemove) {
      _removeTile(key);
    }
  }

  bool _hasLevel(double level) {
    for (Tile tile in _tiles.values) {
      if (tile.coordinate!.z == level) {
        return true;
      }
    }
    return false;
  }

  Level? _updateLevels() {
    log('TileLayer updateLevels');

    final zoom = _tileZoom;
    final maxZoom = options.maxZoom;

    if (zoom == null) {
      return null;
    }

    List<double> zoomToRemove = [];

    _levels.forEach((z, level) {
      if (z == zoom || _hasLevel(z)) {
        level.zIndex = maxZoom! - (zoom - z).abs();
      } else {
        zoomToRemove.add(z);
      }
    });

    for (double z in zoomToRemove) {
      _removeTileAtZoom(z);
      _levels.remove(z);
    }

    if (_levels[zoom] == null) {
      Level level = Level();
      level.zIndex = maxZoom;
      level.origin = map.project(map.unproject(map.pixelOrigin), zoom).round();
      level.zoom = zoom;

      _levels[zoom] = level;
      _setZoomTransform(level, map.center, map.zoom);
    }

    _level = _levels[zoom];
    return _level;
  }

  double _clampZoom(double zoom) {
    bool tooSmall = options.hasMinNativeZoom && (zoom < options.minNativeZoom!);
    bool tooBig = options.hasMaxNativeZoom && (zoom > options.maxNativeZoom!);

    if (tooSmall) {
      return options.minNativeZoom!;
    }

    if (tooBig) {
      return options.maxNativeZoom!;
    }

    return zoom;
  }

  bool _isValid(Coordinate coordinate) {
    final crs = map.options.crs;

    if (!crs.infinite) {
      // don't load tile if it's out of bounds and not wrapped
      final bounds = _globalTileRange!;

      final double x = coordinate.x;
      final double y = coordinate.y;
      final double minX = bounds.min.x;
      final double maxX = bounds.max.x;
      final double minY = bounds.min.y;
      final double maxY = bounds.max.y;

      bool xOutOfBounds = lngBounds != null && (x < minX || x > maxX);
      bool yOutOfBounds = latBounds != null && (y < minY || y > maxY);
      bool outOfBounds = xOutOfBounds || yOutOfBounds;

      if (outOfBounds) {
        return false;
      }
    }

    if (options.hasBounds) {
      final tileBounds = _coordinatesToBounds(coordinate);
      final bounds = LatLngBounds.from(options.bounds);
      return bounds.isOverlaps(tileBounds);
    }

    return true;
  }

  LatLngBounds _coordinatesToBounds(Coordinate coordinate) {
    final nwPoint = coordinate.scaleBy(tileSize);
    final sePoint = nwPoint + tileSize;

    final nw = map.unproject(nwPoint, coordinate.z);
    final se = map.unproject(sePoint, coordinate.z);

    LatLngBounds bounds = LatLngBounds(nw, se);
    return map.wrapLatLngBounds(bounds);
  }

  void _setZoomTransforms(LatLng? center, double zoom) {
    log('TileLayer setZoomTransforms');
    _levels.forEach((key, _) => _setZoomTransform(_levels[key]!, center, zoom));
  }

  void _setZoomTransform(Level level, LatLng? center, double zoom) {
    if (center == null) return;

    final scale = map.getZoomScale(zoom, level.zoom);
    final pixelOrigin = map.getPixelOrigin(center, zoom).round();

    if (level.hasOrigin) {
      level.translate = (level.origin! * scale) - pixelOrigin;
      level.scale = scale;
    }
  }

  UPoint _getTilePosition(Coordinate coordinate) {
    final level = _levels[coordinate.z]!;
    final scaledCoordinates = coordinate.scaleBy(tileSize);
    final tilePos = scaledCoordinates - level.origin!;
    return tilePos.toPoint();
  }

  void _addTile(Coordinate coordinate) {
    log('Add Tile $coordinate');

    final templateUrl = options.getTemplateUrl(crs, coordinate);

    log(options.tileProvider!
        .getTileUrl(templateUrl, _globalTileRange, _wrap(coordinate), options));

    Tile tile = Tile(
      isCurrent: true,
      coordinate: coordinate,
      imageProvider: options.tileProvider!.getImage(
        templateUrl,
        _globalTileRange,
        _wrap(coordinate),
        options,
      ),
      position: _getTilePosition(coordinate),
      level: _levels[coordinate.z],
      onTileReady: _onTileReady,
      maxOpacity: options.opacity,
    )..loadImage();

    _tiles[coordinate.key] = tile;
  }

  Future _onTileReady(Coordinate? coordinate, Tile tile, error) async {
    log('TileLayer onTileReady');

    final key = coordinate?.key;
    tile.isLoadError = error != null;

    if (tile.isLoadError) {
      options.onTileError?.call(tile, error);
      return;
    }

    if (_tiles[key] == null) {
      return;
    }

    double? fadeInStart = tile.isLoaded
        ? options.tileFadeInStart
        : options.tileFadeInStartWhenOverride;

    bool noFadeIn = fadeInStart == 1.0;
    bool showError = tile.isLoadError && options.errorImage == null;

    if (noFadeIn || showError) {
      tile.isActive = true;
    } else {
      tile.show(
        vsync: this,
        duration: options.tileFadeInDuration,
        curve: options.tileFadeInCurve,
        from: fadeInStart,
      );
    }

    if (mounted) setState(() {});

    if (_noTilesToLoad) {
      //bool hasDuration = options!.tileFadeInDuration != null;
      Duration moreDuration = Duration(milliseconds: 50);
      Duration delayDuration = options.tileFadeInDuration + moreDuration;

      await Future.delayed(delayDuration);

      if (mounted)
        setState(() {
          _pruneTiles();
        });
    }
  }

  void _pruneTiles() {
    log('Prune Tiles');

    if (map.zoom > maxZoom! || map.zoom < minZoom!) {
      _removeAllTiles();
      return;
    }

    for (var entry in _tiles.entries) {
      var tile = entry.value;
      tile.isRetain = tile.isCurrent;
    }

    for (var entry in _tiles.entries) {
      final tile = entry.value;
      final c = tile.coordinate;

      if (tile.isCurrent && !tile.isActive) {
        if (!_retainParent(c!.x, c.y, c.z, c.z - 5)) {
          _retainChildren(c.x.round(), c.y.round(), c.z.round(), c.z + 2);
        }
      }
    }

    List<String> toRemove = [];

    for (var entry in _tiles.entries) {
      if (!entry.value.isRetain) {
        toRemove.add(entry.key);
      }
    }

    for (String key in toRemove) {
      _removeTile(key);
    }
  }

  bool _retainParent(double x, double y, double z, double? mz) {
    final x2 = (x / 2).floorToDouble();
    final y2 = (y / 2).floorToDouble();
    final z2 = z - 1;

    final coordinate2 = Coordinate(x2, y2, z2);
    final key = coordinate2.key;
    final tile = _tiles[key];

    if (tile != null) {
      if (tile.isActive) {
        tile.isRetain = true;
        return true;
      } else if (tile.isLoaded) {
        tile.isRetain = true;
      }
    }

    if (z2 > minZoom!) {
      return _retainParent(x2, y2, z2, minZoom);
    }

    return false;
  }

  void _retainChildren(int x, int y, int z, double maxZoom) {
    for (var i = 2 * x; i < 2 * x + 2; i++) {
      for (var j = 2 * y; j < 2 * y + 2; j++) {
        final coordinate = Coordinate(i, j, z + 1);
        final key = coordinate.key;
        final tile = _tiles[key];

        if (tile != null) {
          if (tile.isActive) {
            tile.isRetain = true;
            continue;
          } else if (tile.isLoaded) {
            tile.isRetain = true;
          }
        }

        if (z + 1 < maxZoom) {
          _retainChildren(i, j, z + 1, maxZoom);
        }
      }
    }
  }

  void _removeTileAtZoom(double zoom) {
    log('TileLayer removeTileAtZoom $zoom');

    List<String> toRemove = [];

    for (var entry in _tiles.entries) {
      if (entry.value.coordinate!.z == zoom) {
        toRemove.add(entry.key);
      }
    }

    for (String key in toRemove) {
      _removeTile(key);
    }
  }

  void _removeAllTiles() {
    log('TileLayer removeAllTiles');

    for (String key in _tiles.keys.toList()) {
      _removeTile(key);
    }
  }

  void _removeTile(String key) {
    log('TileLayer removeTile $key');

    final tile = _tiles[key];

    if (tile != null) {
      tile.dispose();
      _tiles.remove(key);
    }
  }
}
