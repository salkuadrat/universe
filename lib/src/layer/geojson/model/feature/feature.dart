// ignore_for_file: library_prefixes

import '../../../layer.dart' as L;
import '../../options.dart';
import '../geometry/collection.dart';
import '../geometry/geometry.dart';
import '../geojson.dart';
import '../type.dart';

class Feature extends GeoJSONModel {
  Geometry? geometry;
  Map<String, dynamic>? properties = {};

  Feature({this.geometry, this.properties});

  @override
  GeoJSONType get type => GeoJSONType.Feature;

  Feature.from(Map<String, dynamic> json) {
    assert(json.containsKey('type') && json['type'] == 'Feature');
    assert(json.containsKey('geometry'));

    Map<String, dynamic> g = json['geometry'];

    if (g.containsKey('type')) {
      String? type = g['type'];

      if (type == 'GeometryCollection') {
        geometry = GeometryCollection.from(g);
      } else {
        geometry = Geometry.from(g);
      }
    }

    if (g.containsKey('properties')) {
      properties = g['properties'];
    }
  }

  @override
  L.MapLayer layer(
    GeoJSONLayerOptions? options, [
    Map<String, dynamic>? properties,
  ]) {
    if (geometry != null) {
      return geometry!.layer(options, this.properties);
    }
    return const L.MapLayer();
  }
}
