// ignore_for_file: library_prefixes

import '../../../../core/core.dart';
import '../../../layer.dart' as L;
import '../../options.dart';
import '../position.dart';
import '../type.dart';
import 'geometry.dart';

class LineString extends Geometry {
  List<Position> _positions = [];

  LineString(List<Position> positions) : _positions = positions.toList();

  @override
  GeoJSONType get type => GeoJSONType.LineString;

  List<Position> get positions => _positions;

  List<LatLng> get latlngs => _positions
      .map((p) => LatLng(p.latitude, p.longitude, p.altitude))
      .toList();

  void add(Position position) {
    _positions.add(position);
  }

  LineString.from(Map<String, dynamic> json) {
    assert(json.containsKey('type') && json['type'] == 'LineString');
    assert(json.containsKey('coordinates'));

    List coordinates = (json['coordinates'] as List);

    for (List c in coordinates as Iterable<List<dynamic>>) {
      add(Position.from(c as List<num>));
    }
  }

  @override
  L.MapLayer layer(GeoJSONLayerOptions? options,
      [Map<String, dynamic>? properties]) {
    return L.PolylineLayer(
      L.Polyline.from(latlngs, data: properties),
      options: options!.lineStringOptions,
    );
  }
}
