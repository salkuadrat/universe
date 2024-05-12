import 'package:proj4dart/proj4dart.dart' as pj4;
import 'package:tuple/tuple.dart';

import '../core.dart';

class Pj4Projection extends Projection {
  final pj4.Projection epsg4326;
  final pj4.Projection pj4Projection;

  Pj4Projection({
    required this.pj4Projection,
    required Bounds? bounds,
    Tuple2<double, double>? latBounds,
    Tuple2<double, double>? lngBounds,
  })  : epsg4326 = pj4.Projection.WGS84,
        super(
          bounds: bounds,
          latBounds: latBounds,
          lngBounds: lngBounds,
        );

  @override
  UPoint project(LatLng? position) {
    pj4.Point point = epsg4326.transform(
        pj4Projection,
        pj4.Point(
          x: position!.lng,
          y: position.lat,
        ));

    return UPoint(point.x, point.y);
  }

  @override
  LatLng unproject(UPoint point) {
    pj4.Point position = pj4Projection.transform(
      epsg4326,
      pj4.Point(x: point.x, y: point.y),
    );
    return LatLng(
      wrapLat(position.y),
      wrapLng(position.x),
    );
  }
}
