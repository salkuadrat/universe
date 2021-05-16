import '../../../layer.dart' as L;
import '../../options.dart';
import '../position.dart';
import '../type.dart';
import 'geometry.dart';
import 'linearring.dart';

class Polygon extends Geometry {
  List<LinearRing> _linearRings = [];

  Polygon(List<LinearRing> linearRings)
      : assert(linearRings.length > 0),
        this._linearRings = linearRings;

  @override
  GeoJSONType get type => GeoJSONType.Polygon;

  List<LinearRing> get all => _linearRings;

  LinearRing get exterior => _linearRings.first;

  List<LinearRing> get interiors {
    List<LinearRing> _all = _linearRings.toList();
    _all.removeAt(0);
    return _all.toList();
  }

  void add(LinearRing lineString) {
    _linearRings.add(lineString);
  }

  Polygon.from(Map<String, dynamic> json) {
    assert(json.containsKey('type') && json['type'] == 'Polygon');
    assert(json.containsKey('coordinates'));

    List coordinates = (json['coordinates'] as List);

    for (List lr in coordinates as Iterable<List<dynamic>>) {
      List<Position> positions = [];
      for (List c in lr as Iterable<List<dynamic>>) {
        positions.add(Position.from(c as List<num>));
      }

      add(LinearRing(positions));
    }
  }

  @override
  L.MapLayer layer(GeoJSONLayerOptions? options,
      [Map<String, dynamic>? properties]) {
    return L.PolygonLayer(
      L.Polygon.from(
        exterior.latlngs,
        holes: interiors.map((lr) => lr.latlngs).toList(),
        data: properties,
      ),
      options: options!.polygonOptions,
    );
  }
}
