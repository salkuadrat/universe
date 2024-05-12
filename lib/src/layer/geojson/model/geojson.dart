// ignore_for_file: unnecessary_getters_setters, library_prefixes

import '../../layer.dart' as L;
import '../options.dart';

import 'bbox.dart';
import 'type.dart';

abstract class GeoJSONModel {
  BoundingBox? _bounds;

  GeoJSONType get type;

  BoundingBox? get bounds => _bounds;

  set bounds(BoundingBox? bounds) {
    _bounds = bounds;
  }

  L.MapLayer layer(GeoJSONLayerOptions? options,
      [Map<String, dynamic>? properties]) {
    return const L.MapLayer();
  }
}
