import '../../../../core/core.dart';
import '../../../layer.dart' as L;
import '../../options.dart';
import '../position.dart';
import '../type.dart';
import 'geometry.dart';

class MultiPoint extends Geometry {
  List<Position> _positions = [];

  MultiPoint(List<Position> positions) : this._positions = positions.toList();

  @override
  GeoJSONType get type => GeoJSONType.MultiPoint;

  List<Position> get positions => _positions;

  List<LatLng> get latlngs => _positions
      .map((p) => LatLng(p.latitude, p.longitude, p.altitude))
      .toList();

  void add(Position position) {
    _positions.add(position);
  }

  MultiPoint.from(Map<String, dynamic> json) {
    assert(json.containsKey('type') && json['type'] == 'MultiPoint');
    assert(json.containsKey('coordinates'));

    List coordinates = (json['coordinates'] as List);

    for (List c in coordinates as Iterable<List<dynamic>>) {
      add(Position.from(c as List<num>));
    }
  }

  @override
  L.MapLayer layer(GeoJSONLayerOptions? options,
      [Map<String, dynamic>? properties]) {
    if (options!.pointAs == GeoJSONPointAs.Circle) {
      return L.CircleLayer(
        positions
            .map((p) => L.Circle.from(
                  p,
                  radius: options.pointRadius,
                  radiusUnit: options.radiusUnit,
                  data: properties,
                ))
            .toList(),
        options: options.circleOptions,
      );
    } else {
      return L.MarkerLayer(
        positions.map((p) => L.Marker.from(p)).toList(),
        options: options.pointOptions,
      );
    }
  }
}
