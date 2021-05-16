import '../../../../core/core.dart';
import '../../../layer.dart' as L;
import '../../options.dart';
import '../position.dart';
import '../type.dart';
import 'geometry.dart';

class Point extends Geometry {
  Position? _position;

  Point(dynamic x, [num? y, num? z]) {
    if (x is Point) {
      _position = Position(x.lattiude, x.longitude, x.altitude);
    }

    if (x is Position) {
      _position = Position(x.latitude, x.longitude, x.altitude);
    }

    if (x is num && y is num) {
      if (z is num) {
        _position = Position(x, y, z);
      } else {
        _position = Position(x, y);
      }
    }
  }

  @override
  GeoJSONType get type => GeoJSONType.Point;

  Position? get position => _position;

  double get lattiude => _position!.latitude;

  double get longitude => _position!.longitude;

  double get altitude => _position!.altitude;

  LatLng get latlng => _position!.latlng;

  Point.from(Map<String, dynamic> json) {
    assert(json.containsKey('type') && json['type'] == 'Point');
    assert(json.containsKey('coordinates'));

    this._position = Position.from((json['coordinates'] as List) as List<num>);
  }

  @override
  L.MapLayer layer(GeoJSONLayerOptions? options,
      [Map<String, dynamic>? properties]) {
    if (options!.pointAs == GeoJSONPointAs.Circle) {
      return L.CircleLayer(
        L.Circle.from(
          latlng,
          radius: options.pointRadius,
          radiusUnit: options.radiusUnit,
          data: properties,
        ),
        options: options.circleOptions,
      );
    } else {
      return L.MarkerLayer(
        L.Marker.from(latlng),
        options: options.pointOptions,
      );
    }
  }
}
