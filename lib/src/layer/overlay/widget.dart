import 'package:flutter/widgets.dart';

import '../../core/core.dart';
import '../../map/map.dart';
import '../layer.dart';

class WidgetOverlay extends InteractiveLayer {
  final Widget? child;
  final LatLngBounds bounds;
  final double? opacity;
  final double? rotation;
  final dynamic data;
  final InteractiveLayerOptions? options;

  WidgetOverlay({
    this.child,
    required dynamic bounds,
    this.opacity,
    this.rotation,
    this.data,
    this.options,
  })  : assert(bounds != null),
        this.bounds = LatLngBounds.from(bounds),
        super(options: options);

  @override
  Widget buildLayer(BuildContext context, MapStates map) {
    final pixelOrigin = map.pixelOrigin;
    final scale = map.getZoomScale(map.zoom, map.zoom);
    final nw = map.project(bounds.northWest);
    final se = map.project(bounds.southEast);

    final topLeft = (nw * scale) - pixelOrigin;
    final bottomRight = (se * scale) - pixelOrigin;

    final double top = topLeft.y;
    final double left = topLeft.x;
    final width = bottomRight.x - topLeft.x;
    final height = bottomRight.y - topLeft.y;
    final opacity = this.opacity ?? 1.0;

    return Positioned(
      top: top,
      left: left,
      width: width,
      height: height,
      child: InteractiveGestureDetector(
        position: bounds,
        data: data,
        options: options,
        child: Opacity(
          opacity: opacity,
          child: child,
        ),
      ),
    );
  }
}
