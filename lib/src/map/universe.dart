import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import '../core/geometry/point.dart';
import '../core/geometry/size.dart';
import '../core/latlng/latlng.dart';
import '../layer/base/layer.dart';
import '../layer/marker/layer.dart';
import '../layer/tile/layer.dart';
import 'controller/base.dart';
import 'controller/default.dart';
import 'interactive/gesture.dart';
import 'interactive/tap_position.dart';
import 'options/map.dart';
import 'manager.dart';
import 'state.dart';

class Universe extends StatelessWidget {

  final MapOptions options;
  final MapController controller;
  final TileLayer baseLayer;
  final MarkerLayer marker;
  final List<UniverseLayer> layers;

  const Universe({
    Key key, 
    this.options, 
    this.controller, 
    this.baseLayer,
    this.marker,
    this.layers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapOptions opts = options ?? MapOptions();
    MapOptions mapOptions;

    // set default size to follow screen size
    if(opts.size == null) {
      var _size = MediaQuery.of(context).size;
      mapOptions = opts.copyWith(size: Size(_size.width, _size.height));
    } else {
      mapOptions = opts;
    }

    MapState initialState = MapState(
      controller: controller ?? UMapController(),
      options: mapOptions,
    );

    return CubitProvider(
      create: (_) => MapManager(initialState),
      child: _UniverseContainer(baseLayer: baseLayer, marker: marker, layers: layers),
    );
  }
}

class _UniverseContainer extends StatefulWidget {

  final TileLayer baseLayer;
  final MarkerLayer marker;
  final List<UniverseLayer> layers;

  _UniverseContainer({Key key, this.baseLayer, this.marker, this.layers}) : super(key: key);

  @override
  _UniverseContainerState createState() => _UniverseContainerState();
}

class _UniverseContainerState extends State<_UniverseContainer> 
  with TickerProviderStateMixin, MapGestureMixin {

  MapManager get manager => context.cubit<MapManager>();
  MapState get state => manager.state;
  MapController get controller => manager.state.controller;

  bool get hasBaseLayer => widget.baseLayer != null;
  bool get hasMarker => widget.marker != null;
  bool get hasLayers => widget.layers != null && widget.layers.isNotEmpty;

  final TapPositionController _tapPositionController = TapPositionController();

  LatLng _centerStart;
  double _zoomStart;
  LatLng _focalStartGlobal;
  UPoint _focalStartLocal;

  RenderBox get render => context.findRenderObject() as RenderBox;
  double get renderWidth => render?.size?.width ?? 0.0;
  double get renderHeight => render?.size?.height ?? 0.0;

  @override
  void initState() {
    super.initState();
    manager?.init();
  }

  @override
  void dispose() {
    manager?.dispose();
    super.dispose();
  }

  List<Widget> get _layers => [
    if(hasBaseLayer) widget.baseLayer,
    if(hasLayers) ...widget.layers,
    if(hasMarker) widget.marker,
  ];

  Widget get _stack => Stack(
    children: _layers,
  );

  Widget get _interactive => TapPositionDetector(
    controller: _tapPositionController,
    onLongPress: handleLongPress,
    onDoubleTap: handleDoubleTap,
    onTap: handleTap,
    child: GestureDetector(
      onScaleStart: handleScaleStart,
      onScaleUpdate: handleScaleUpdate,
      onScaleEnd: handleScaleEnd,
      onLongPress: _tapPositionController.onLongPress,
      onTapDown: _tapPositionController.onTapDown,
      onTap: _tapPositionController.onTap,
      onTapUp: handleOnTapUp,
      child: _stack,
    ),
  );

  Widget get _map => state.options.interactive ? _interactive : _stack;

  Widget get _rotatedMap => CubitBuilder<MapManager, MapState>(
    builder: (_, __) => ClipRect(
      child: Transform.rotate(
        angle: state.angle,
        child: OverflowBox(
          minWidth: state.width,
          maxWidth: state.width,
          minHeight: state.height,
          maxHeight: state.height,
        ),
      ),
    ),
  );

  Widget get _root => state.hasRotation ? _rotatedMap : _map;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints c) {
        //manager?.resize(c.maxWidth, c.maxHeight);
        return _root;
      },
    );
  }

  @override
  void handleTap(TapPosition position) {
    if(state?.options?.onTap is Function) {
      state?.options?.onTap(
        state.offsetToLatLng(position.local, renderWidth, renderHeight));
    }
  }

  @override
  void handleOnTapUp(TapUpDetails details) {
    // TODO: implement handleOnTapUp
  }

  @override
  void handleDoubleTap(TapPosition tapPosition) {
    // TODO: implement handleDoubleTap
  }

  @override
  void handleLongPress(TapPosition position) {
    // TODO: implement handleLongPress
  }

  @override
  void handleScaleEnd(ScaleEndDetails details) {
    // TODO: implement handleScaleEnd
  }

  @override
  void handleScaleStart(ScaleStartDetails details) {
    // TODO: implement handleScaleStart
  }

  @override
  void handleScaleUpdate(ScaleUpdateDetails details) {
    // TODO: implement handleScaleUpdate
  }
}