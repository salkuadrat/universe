// ignore_for_file: library_prefixes, unnecessary_getters_setters

import '../../../layer.dart' as L;
import '../../options.dart';
import '../type.dart';
import 'geometry.dart';

class GeometryCollection extends Geometry {
  List<Geometry> _geometries = [];

  GeometryCollection(List<Geometry> geometries) : _geometries = geometries;

  @override
  GeoJSONType get type => GeoJSONType.MultiPolygon;

  List<Geometry> get geometries => _geometries;

  set geometries(List<Geometry> geometries) {
    _geometries = geometries;
  }

  void add(Geometry geometry) {
    _geometries.add(geometry);
  }

  GeometryCollection.from(Map<String, dynamic> json) {
    assert(json.containsKey('type') && json['type'] == 'GeometryCollection');
    assert(json.containsKey('geometries'));

    List geometries = (json['geometries'] as List);

    for (Map<String, dynamic> g
        in geometries as Iterable<Map<String, dynamic>>) {
      Geometry? geometry = Geometry.from(g);

      if (geometry != null) {
        add(geometry);
      }
    }
  }

  @override
  L.MapLayer layer(GeoJSONLayerOptions? options,
      [Map<String, dynamic>? properties]) {
    return L.GroupLayer(
      layers: geometries.map((g) => g.layer(options, properties)).toList(),
      options: options,
    );
  }
}
