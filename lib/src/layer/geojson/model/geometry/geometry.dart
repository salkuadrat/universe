import '../geojson.dart';
import '../type.dart';
import 'linestring.dart';
import 'multilinestring.dart';
import 'multipoint.dart';
import 'multipolygon.dart';
import 'point.dart';
import 'polygon.dart';

class Geometry extends GeoJSONModel {
  @override
  GeoJSONType get type => GeoJSONType.Geometry;

  static Geometry? from(Map<String, dynamic> json) {
    assert(json.containsKey('type'));

    String? type = json['type'];

    switch (type) {
      case 'Point':
        return Point.from(json);
      case 'MultiPoint':
        return MultiPoint.from(json);
      case 'LineString':
        return LineString.from(json);
      case 'MultiLineString':
        return MultiLineString.from(json);
      case 'Polygon':
        return Polygon.from(json);
      case 'MultiPolygon':
        return MultiPolygon.from(json);
    }

    return null;
  }
}
