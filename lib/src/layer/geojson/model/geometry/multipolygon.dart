// ignore_for_file: unnecessary_getters_setters

import '../position.dart';
import '../type.dart';
import 'geometry.dart';
import 'linearring.dart';
import 'polygon.dart';

class MultiPolygon extends Geometry {
  List<Polygon> _polygons = [];

  MultiPolygon(List<Polygon> polygons) : _polygons = polygons;

  @override
  GeoJSONType get type => GeoJSONType.MultiPolygon;

  List<Polygon> get polygons => _polygons;

  set polygons(List<Polygon> polygons) {
    _polygons = polygons;
  }

  void add(Polygon polygon) {
    _polygons.add(polygon);
  }

  MultiPolygon.from(Map<String, dynamic> json) {
    assert(json.containsKey('type') && json['type'] == 'MultiPolygon');
    assert(json.containsKey('coordinates'));

    List coordinates = (json['coordinates'] as List);

    for (List p in coordinates as Iterable<List<dynamic>>) {
      List<LinearRing> linearRings = [];

      for (List lr in p as Iterable<List<dynamic>>) {
        List<Position> positions = [];

        for (List c in lr as Iterable<List<dynamic>>) {
          positions.add(Position.from(c as List<num>));
        }

        linearRings.add(LinearRing(positions));
      }

      add(Polygon(linearRings));
    }
  }

  /* @override
  L.MapLayer layer(GeoJSONLayerOptions options, [Map<String, dynamic> properties]) {
       
  } */
}
