import 'point.dart';

class Transformation {
  
  final num a;
  final num b;
  final num c;
  final num d;

  const Transformation(this.a, this.b, this.c, this.d);

  GeoPoint transform(GeoPoint point, double scale) {
    scale ??= 1.0;
    var x = scale * (a * point.x + b);
    var y = scale * (c * point.y + d);
    return GeoPoint(x, y);
  }

  GeoPoint untransform(GeoPoint point, double scale) {
    scale ??= 1.0;
    var x = (point.x / scale - b) / a;
    var y = (point.y / scale - d) / c;
    return GeoPoint(x, y);
  }
}