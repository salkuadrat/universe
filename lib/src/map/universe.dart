import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../control/control.dart' as C;
import '../core/core.dart';
import '../layer/layer.dart';
import '../shared.dart';
import 'map.dart';

/// Main class of Map Universe
class Universe extends StatelessWidget {
  /// Map options
  final MapOptions options;

  /// Map controller
  final MapController? controller;

  /// Background color of this map.
  final Color? background;

  /// Base tile layer of this map.
  final TileLayer? base;

  /// List markers to show on this map.
  final MarkerLayer? markers;

  /// List circles to show on this map.
  final CircleLayer? circles;

  /// List polylines to show on this map.
  final PolylineLayer? polylines;

  /// List polygons to show on this map.
  final PolygonLayer? polygons;

  /// List rectangles to show on this map.
  final RectangleLayer? rectangles;

  /// List of additional tile layers to show on this map.
  final List<TileLayer> tiles;

  /// List image overlays to show on this map.
  final List<ImageOverlay> images;

  /// List video overlays to show on this map.
  final List<VideoOverlay> videos;

  /// List of additional custom layers to show on this map.
  final List<MapLayer> layers;

  /// List of additional custom controls to show on this map.
  final List<Widget> controls;

  const Universe({
    Key? key,
    required this.options,
    this.controller,
    this.background,
    this.base,
    this.markers,
    this.circles,
    this.polylines,
    this.polygons,
    this.rectangles,
    this.tiles = const [],
    this.images = const [],
    this.videos = const [],
    this.layers = const [],
    this.controls = const [],
  })  : assert(layers is List<MapLayer>),
        super(key: key);

  /// Has base tile layer.
  bool get hasBase => base != null;

  /// Has list circles.
  bool get hasCircles => circles != null;

  /// Has list polylines.
  bool get hasPolylines => polylines != null;

  /// Has list polygons.
  bool get hasPolygons => polygons != null;

  /// Has list rectangles.
  bool get hasRectangles => rectangles != null;

  /// Has additional tile layers.
  bool get hasTiles => tiles.isNotEmpty;

  /// Has image overlays.
  bool get hasImages => images.isNotEmpty;

  /// Has video overlays.
  bool get hasVideos => videos.isNotEmpty;

  /// Has additional custom layers.
  bool get hasLayers => layers.isNotEmpty;

  /// Has markers.
  bool get hasMarkers => markers != null;

  @override
  Widget build(BuildContext context) {
    MapOptions mapOptions = options;
    String attribution = base?.options.attribution ?? options.attribution;

    if (mapOptions.noSize) {
      final screenSize = MediaQuery.of(context).size;

      mapOptions = mapOptions.copyWith(
        size: Size(screenSize.width, screenSize.height),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => MapState(
        controller: controller ?? MapController(),
        options: mapOptions,
      ),
      child: Container(
        color: background,
        child: _Map(
          layers: [
            if (hasBase) base!,
            if (hasTiles) ...tiles,
            if (hasLayers) ...layers,
            if (options.showLocationIndicator &&
                !options.showLocationMarker &&
                options.hasLocationIndicator)
              options.locationIndicator!,
            if (hasCircles) circles!,
            if (hasPolylines) polylines!,
            if (hasPolygons) polygons!,
            if (hasRectangles) rectangles!,
            if (hasImages) ...images,
            if (hasVideos) ...videos,
            if (hasMarkers) markers!,
          ],
          controls: controls,
          attribution: attribution,
        ),
      ),
    );
  }
}

class _Map extends StatefulWidget {
  final List<Widget> layers;
  final List<Widget> controls;
  final String? attribution;

  _Map({
    Key? key,
    this.layers = const [],
    this.controls = const [],
    this.attribution,
  }) : super(key: key);

  @override
  __MapState createState() => __MapState();
}

class __MapState extends State<_Map> with TickerProviderStateMixin {
  late MapState map;
  late ValueNotifier<double> rotationNotifier;
  bool get hasLayers => widget.layers.isNotEmpty;

  late double _width;
  late double _height;
  late Size _originalSize;

  @override
  void initState() {
    var self = this;
    super.initState();

    map = Provider.of<MapState>(context, listen: false);
    rotationNotifier = ValueNotifier(0.0);
    _originalSize = Size(map.width, map.height);
    _width = map.width;
    _height = map.height;

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await map.init(self, _resize);
      _resize();
      map.rotate(map.originalRotation);
    });
  }

  @override
  void dispose() {
    map.close();
    super.dispose();
  }

  void _resize() {
    map = Provider.of<MapState>(context, listen: false);
    final size = projectedSize(_originalSize, map.angle);

    setState(() {
      _width = size.width;
      _height = size.height;
      rotationNotifier.value = map.angle;
    });

    map.resize(_width, _height);
  }

  get _layers => Transform.rotate(
        angle: rotationNotifier.value,
        child: OverflowBox(
          minWidth: _width,
          minHeight: _height,
          maxWidth: _width,
          maxHeight: _height,
          child: Stack(
            children: [
              ...widget.layers,
              _locationMarker,
              _centerMarker,
            ],
          ),
        ),
      );

  get _centerMarker => Consumer<MapState>(
        builder: (_, map, __) => map.showCenterMarker
            ? MarkerLayer(
                Marker(map.center),
                options: MarkerLayerOptions(widget: map.centerMarker),
              )
            : Container(),
      );

  get _locationMarker => Consumer<MapState>(
        builder: (_, map, __) => map.showLocationMarker
            ? MarkerLayer(
                Marker(map.position),
                options: MarkerLayerOptions(widget: map.locationMarker),
              )
            : Container(),
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<MapState>(
      builder: (_, map, __) {
        this.map = map;
        bool showLocator = map.options.interactive && map.options.showLocator;
        bool showCompass = map.options.interactive &&
            map.options.canRotate &&
            map.options.showCompass;
        bool showScale = map.options.showScale;
        bool hasControls = widget.controls.isNotEmpty;

        return Stack(
          children: [
            map.options.interactive
                ? MapGestureDetector(child: _layers)
                : _layers,
            map.options.hideAttribution
                ? Container()
                : C.Attribution(widget.attribution),
            if (showScale) map.options.scale ?? C.Scale(),
            if (showLocator) map.options.locator ?? C.Locator(),
            if (showCompass) map.options.compass ?? C.Compass(),
            if (hasControls) ...widget.controls,
          ],
        );
      },
    );
  }
}
