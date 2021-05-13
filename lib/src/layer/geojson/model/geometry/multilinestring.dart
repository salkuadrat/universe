import '../../../layer.dart' as L;
import '../../options.dart';
import '../position.dart';
import '../type.dart';
import 'geometry.dart';
import 'linestring.dart';

class MultiLineString extends Geometry {
  
  List<LineString> _lines = [];

  @override
  GeoJSONType get type => GeoJSONType.MultiLineString;

  List<LineString> get lines => _lines;

  MultiLineString(List<LineString> lines) 
    : this._lines = lines.toList();
  
  void add(LineString lineString) {
    _lines.add(lineString);
  }

  MultiLineString.from(Map<String, dynamic> json) {
    assert(json.containsKey('type') && json['type'] == 'MultiLineString');
    assert(json.containsKey('coordinates'));

    List coordinates = (json['coordinates'] as List);

    for(List ls in coordinates as Iterable<List<dynamic>>) {
      List<Position> positions = [];
      for(List c in ls as Iterable<List<dynamic>>) {
        positions.add(Position.from(c as List<num>));
      }

      add(LineString(positions));
    }
  }

  @override
  L.MapLayer layer(GeoJSONLayerOptions? options, [Map<String, dynamic>? properties]) {
    return L.PolylineLayer(
      L.Polyline.from(lines.map((l) => 
        L.Polyline.from(l.latlngs, data: properties)).toList()),
      options: options!.lineStringOptions,
    );
  }
}