import '../../layer.dart' as L;
import '../options.dart';

import 'bbox.dart';
import 'type.dart';

abstract class GeoJSONModel {

  BoundingBox? _bounds;

  GeoJSONType get type;

  BoundingBox? get bounds => _bounds;

  set bounds(BoundingBox? bounds) {
    this._bounds = bounds;
  }

  L.MapLayer layer(GeoJSONLayerOptions? options, [Map<String, dynamic>? properties]) {
    return L.MapLayer();
  }
}