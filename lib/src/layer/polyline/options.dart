import 'package:universe/src/layer/base/options.dart';

import 'marker.dart';

class PolylineLayerOptions extends LayerOptions {
  final Polyline polyline;
  final bool culling;

  const PolylineLayerOptions(this.polyline, {this.culling=false});
}

class MultiPolylineLayerOptions extends LayerOptions {
  final List<Polyline> polylines;
  final bool culling;

  const MultiPolylineLayerOptions(this.polylines, {this.culling=false});
}