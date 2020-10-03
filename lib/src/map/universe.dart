import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:universe/src/layer/control/attribution/layer.dart';
import 'package:universe/src/layer/control/locator/layer.dart';
import 'package:universe/src/layer/control/locator/marker.dart';

import '../core/core.dart';
import '../layer/layer.dart';
import '../shared.dart';
import 'map.dart';

class Universe extends StatelessWidget {

  final MapOptions options;
  final MapController controller;
  final Color background;
  final TileLayer base;
  final MarkerLayer markers;
  final CircleLayer circles;
  final PolylineLayer polylines;
  final PolygonLayer polygons;
  final RectangleLayer rectangles;
  final List<MapLayer> layers;
  final List<LayerOptions> layerOptions;

  const Universe({
    Key key, 
    this.options, 
    this.controller, 
    this.background,
    this.base,
    this.markers,
    this.circles,
    this.polylines,
    this.polygons,
    this.rectangles,
    List layers,
  }) : 
    assert(base != null || layers is List<MapLayer> || layers is List<LayerOptions>),
    this.layers = layers is List<MapLayer> ? layers : const [],
    this.layerOptions = layers is List<LayerOptions> ? layers : const [],
    super(key: key);
  
  bool get hasCircles => circles != null;
  bool get hasPolylines => polylines != null;
  bool get hasPolygons => polygons != null;
  bool get hasRectangles => rectangles != null;
  
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
      controller: controller ?? UMapController(),
      options: mapOptions,
    );

    String attribution = '';

    if(base != null) {
      attribution = base.options.attribution;
    } else {
      attribution = options.attribution;
    }

    return CubitProvider(
      create: (_) => MapStateManager(initialState),
      child: Container(
        color: background,
        child: _Map(
          base: base, 
          markers: markers, 
          layers: [
            if(hasCircles) circles,
            if(hasPolylines) polylines,
            if(hasPolygons) polygons,
            if(hasRectangles) rectangles,
            ...layers,
          ], 
          layerOptions: layerOptions,
          attribution: attribution,
        ),
      ),
    );
  }
}

class _Map extends StatefulWidget {

  final TileLayer base;
  final MarkerLayer markers;
  final List<MapLayer> layers;
  final List<LayerOptions> layerOptions;
  final String attribution;

  _Map({
    Key key, 
    this.base, 
    this.markers, 
    this.layers,
    this.layerOptions,
    this.attribution,
  }) : super(key: key);

  @override
  __MapState createState() => __MapState();
}

class __MapState extends State<_Map> {

  MapStateManager get manager => context.cubit<MapStateManager>();
  MapState get map => manager.state;

  bool get hasBaseLayer => widget.base != null;
  bool get hasMarkers => widget.markers != null;
  bool get hasLayers => widget.layers != null && widget.layers.isNotEmpty;
  bool get hasLayerOptions => widget.layerOptions != null && widget.layerOptions.isNotEmpty;

  RenderBox get render => context.findRenderObject() as RenderBox;
  double get renderWidth => render?.size?.width ?? 0.0;
  double get renderHeight => render?.size?.height ?? 0.0;

  ValueNotifier<double> rotationNotifier = ValueNotifier(0.0);

  double _originalWidth;
  double _originalHeight;
  double _width;
  double _height;

  @override
  void initState() {
    _originalWidth = map.width;
    _originalHeight = map.height;
    _width = map.width;
    _height = map.height;
    super.initState();
    manager?.init();

    rotationNotifier.value = manager.angle;
    manager?.setAngleListener(_onChanged);
  }

  @override
  void dispose() {
    manager?.dispose();
    super.dispose();
  }

  Widget _layer(options) {
    return Container();
  }

  Widget get _layers => Center(
    child: Stack(
      children: [
        if(hasBaseLayer) widget.base,
        if(hasLayers) ...widget.layers,
        if(hasLayerOptions) ...widget.layerOptions
          .map((options) => _layer(options))
          .toList(),
        if(hasMarkers) widget.markers,
      ],
    ),
  );

  Widget get _interactive => MapGestureDetector(
    child: Transform.rotate(
      angle: rotationNotifier.value,
      alignment: FractionalOffset.center,
      child: OverflowBox(
        minWidth: _width,
        minHeight: _height,
        maxWidth: _width,
        maxHeight: _height,
        child: _layers,
      ),
    ),
  );

  Widget get _map => map.options.interactive ? _interactive : _layers;

  void _onChanged() {
    rotationNotifier.value = manager.angle;

    final angle = manager.angle;
    final originalSize = Size(_originalWidth, _originalHeight);
    final size = projectedSize(originalSize, angle);
    
    setState(() {
      _width = size.width;
      _height = size.height;
    });

    manager?.resize(size.width, size.height);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _map,
        AttributionLayer(widget.attribution),
        if(map.options.locator) LocatorLayer(Locator(icon: Icons.location_searching)),
      ],
    );
  }
}