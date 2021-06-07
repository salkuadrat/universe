import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../control/control.dart' as C;
import '../core/core.dart';
import '../layer/layer.dart';
import '../shared.dart';
import 'map.dart';

class Universe extends StatelessWidget {
  final MapOptions options;
  final MapController? controller;
  final Color? background;
  final TileLayer? base;
  final MarkerLayer? markers;
  final CircleLayer? circles;
  final PolylineLayer? polylines;
  final PolygonLayer? polygons;
  final RectangleLayer? rectangles;
  final List<TileLayer> tiles;
  final List<ImageOverlay> images;
  final List<VideoOverlay> videos;
  final List<MapLayer> layers;
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

  bool get hasBase => base != null;
  bool get hasCircles => circles != null;
  bool get hasPolylines => polylines != null;
  bool get hasPolygons => polygons != null;
  bool get hasRectangles => rectangles != null;
  bool get hasTiles => tiles.isNotEmpty;
  bool get hasImages => images.isNotEmpty;
  bool get hasVideos => videos.isNotEmpty;
  bool get hasLayers => layers.isNotEmpty;
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
  MapState get map => Provider.of<MapState>(context, listen: false);
  bool get hasLayers => widget.layers.isNotEmpty;

  ValueNotifier<double> rotationNotifier = ValueNotifier(0.0);

  late double _width;
  late double _height;
  late Size _originalSize;

  @override
  void initState() {
    var self = this;

    _originalSize = Size(map.width, map.height);
    _width = map.width;
    _height = map.height;

    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await map.init(self, _resize);
      _resize();
      map.rotate(map.originalRotation);
    });
  }

  @override
  void dispose() {
    map.dispose();
    super.dispose();
  }

  void _resize() {
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
              if (map.showLocationMarker) _locationMarker,
              if (map.showCenterMarker) _centerMarker,
            ],
          ),
        ),
      );

  get _centerMarker => MarkerLayer(
        Marker(map.center),
        options: MarkerLayerOptions(widget: map.centerMarker),
      );

  get _locationMarker => MarkerLayer(
        Marker(map.position),
        options: MarkerLayerOptions(widget: map.locationMarker),
      );

  get _locator =>
      map.options.locator != null ? map.options.locator : C.Locator();

  get _compass =>
      map.options.compass != null ? map.options.compass : C.Compass();

  get _scale => map.options.scale != null ? map.options.scale : C.Scale();

  @override
  Widget build(BuildContext context) {
    bool showLocator = map.options.interactive && map.options.showLocator;
    bool showCompass = map.options.interactive &&
        map.options.canRotate &&
        map.options.showCompass;
    bool showScale = map.options.showScale;
    bool hasControls = widget.controls.isNotEmpty;

    return Consumer<MapState>(
      builder: (context, map, child) => Stack(
        children: [
          map.options.interactive
              ? MapGestureDetector(child: _layers)
              : _layers,
          map.options.hideAttribution
              ? Container()
              : C.Attribution(widget.attribution),
          if (showScale) _scale,
          if (showLocator) _locator,
          if (showCompass) _compass,
          if (hasControls) ...widget.controls,
        ],
      ),
    );
  }
}
