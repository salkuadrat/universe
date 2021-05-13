import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import '../control/control.dart';
import '../core/core.dart';
import '../layer/layer.dart';
import '../shared.dart';
import 'map.dart';

class Universe extends StatelessWidget {

  final MapOptions? options;
  final MapController? controller;
  final Color? background;
  final TileLayer? base;
  final MarkerLayer? markers;
  final CircleLayer? circles;
  final PolylineLayer? polylines;
  final PolygonLayer? polygons;
  final RectangleLayer? rectangles;
  final List<ImageOverlay>? images;
  final List<VideoOverlay>? videos;
  final List<MapLayer>? layers;
  final List<Widget>? controls;

  const Universe({
    Key? key, 
    this.options, 
    this.controller, 
    this.background,
    this.base,
    this.markers,
    this.circles,
    this.polylines,
    this.polygons,
    this.rectangles,
    this.images,
    this.videos,
    this.layers,
    this.controls,
  }) : 
    assert(base != null || layers is List<MapLayer>),
    super(key: key);
  
  bool get hasBaseLayer => base != null;
  bool get hasCircles => circles != null;
  bool get hasPolylines => polylines != null;
  bool get hasPolygons => polygons != null;
  bool get hasRectangles => rectangles != null;
  bool get hasImages => images != null && images!.isNotEmpty;
  bool get hasVideos => videos != null && videos!.isNotEmpty;
  bool get hasLayers => layers != null && layers!.isNotEmpty;
  bool get hasMarkers => markers != null;
  
  @override
  Widget build(BuildContext context) {
    MapOptions mapOptions = options ?? MapOptions();
    
    if(mapOptions.noSize) {
      final screenSize = MediaQuery.of(context).size;

      mapOptions = mapOptions.copyWith(
        size: Size(screenSize.width, screenSize.height),
      );
    }

    MapState initialState = MapState(
      controller: controller ?? MapController(),
      options: mapOptions,
    );

    String attribution = '';

    if(base != null) {
      attribution = base!.options!.attribution;
    } else {
      attribution = options!.attribution;
    }

    return CubitProvider(
      create: (_) => MapStateManager(initialState),
      child: Container(
        color: background,
        child: _Map(
          layers: [
            if(hasBaseLayer) base,
            if(hasLayers) ...layers!,
            if(options!.showLocationIndicator! && !options!.showLocationMarker) options!.locationIndicator,
            if(hasCircles) circles,
            if(hasPolylines) polylines,
            if(hasPolygons) polygons,
            if(hasRectangles) rectangles,
            if(hasImages) ...images!,
            if(hasVideos) ...videos!,
            if(hasMarkers) markers,
          ],
          controls: controls,
          attribution: attribution,
        ),
      ),
    );
  }
}

class _Map extends StatefulWidget {

  final List<Widget?>? layers;
  final List<Widget>? controls;
  final String? attribution;

  _Map({
    Key? key, 
    this.layers,
    this.controls,
    this.attribution,
  }) : super(key: key);

  @override
  __MapState createState() => __MapState();
}

class __MapState extends State<_Map> 
  with TickerProviderStateMixin {

  MapStateManager get manager => context.cubit<MapStateManager>();
  MapState get map => manager.state;
  bool get hasLayers => widget.layers != null && widget.layers!.isNotEmpty;

  ValueNotifier<double> rotationNotifier = ValueNotifier(0.0);

  late double _originalWidth;
  late double _originalHeight;
  double? _width;
  double? _height;

  @override
  void initState() {
    _originalWidth = map.width;
    _originalHeight = map.height;
    _width = map.width;
    _height = map.height;

    super.initState();
    manager.init(this);
    manager.setAngleListener(_resize);
    _resize();
  }

  void _resize() {
    final angle = manager.angle;
    final originalSize = Size(_originalWidth, _originalHeight);
    final size = projectedSize(originalSize, angle);
    
    rotationNotifier.value = angle;

    if(mounted) setState(() {  
      _width = size.width;
      _height = size.height;
    });

    manager.resize(size.width, size.height);
  }

  void _refresh() {
    if(mounted) setState(() {});
  }

  Widget get _layers => Transform.rotate(
    angle: rotationNotifier.value,
    alignment: FractionalOffset.center,
    child: OverflowBox(
      minWidth: _width,
      minHeight: _height,
      maxWidth: _width,
      maxHeight: _height,
      child: Stack(
        children: [
          ...widget.layers as Iterable<Widget>,
          if(map.showLocationMarker) _locationMarker,
          if(map.showCenterMarker) _centerMarker,
        ],
      ),
    ),
  );

  Widget get _centerMarker => MarkerLayer(
    Marker(map.center),
    options: MarkerLayerOptions(widget: map.centerMarker),
  );

  Widget get _locationMarker => MarkerLayer(
    Marker(map.location),
    options: MarkerLayerOptions(widget: map.locationMarker),
  );

  Widget? get _locator => map.options!.locator != null 
    ? map.options!.locator 
    : Locator();
  
  Widget? get _compass => map.options!.compass != null 
    ? map.options!.compass 
    : Compass();

  Widget? get _scale => map.options!.scale != null 
    ? map.options!.scale 
    : Scale();

  @override
  Widget build(BuildContext context) {
    bool showLocator = map.options!.interactive && map.options!.showLocator;
    bool showCompass = map.options!.interactive && map.options!.canRotate && map.options!.showCompass;
    bool showScale = map.options!.showScale;
    bool hasControls = widget.controls != null;

    return CubitListener<MapStateManager, MapState>(
      listenWhen: (old, current) {
        return old.center != current.center || old.location != current.location;
      },
      listener: (old, current) => _refresh(),
      child: Stack(
        children: [
          map.options!.interactive 
            ? MapGestureDetector(child: _layers) 
            : _layers,
          map.options!.hideAttribution 
            ? Container() 
            : Attribution(widget.attribution),
          if(showScale) _scale!,
          if(showLocator) _locator!,
          if(showCompass) _compass!,
          if(hasControls) ...widget.controls!,
        ],
      ),
    );
  }
}