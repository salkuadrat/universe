import '../base/options.dart';
import 'marker.dart';

class PolygonLayerOptions extends LayerOptions {

  final Polygon polygon;

  const PolygonLayerOptions(this.polygon);
}

class MultiPolygonLayerOptions extends LayerOptions {

  final List<Polygon> polygons;

  const MultiPolygonLayerOptions(this.polygons);
}