import '../../../validate/validate.dart';

class Point2D<T extends num?> {
  final T x;
  final T y;

  Point2D(this.x, this.y);
}

abstract class CatmullRom<T> {
  const CatmullRom();

  T position(double distance);
  T percentage(num percent) => position(percent / 100);
}

class CatmullRomSpline<T extends num> extends CatmullRom<double> {
  final T _p0, _p1, _p2, _p3;

  const CatmullRomSpline(this._p0, this._p1, this._p2, this._p3);
  const CatmullRomSpline.noEndpoints(final T p1, final T p2)
      : _p0 = p1,
        _p1 = p1,
        _p2 = p2,
        _p3 = p2;

  @override
  double position(final double distance) {
    Validate.inclusiveBetween(
        0, 1, distance, "Distance must be beteen 0 and 1 but was $distance");

    return 0.5 *
        ((2 * _p1) +
            (_p2 - _p0) * distance +
            (2 * _p0 - 5 * _p1 + 4 * _p2 - _p3) * distance * distance +
            (3 * _p1 - _p0 - 3 * _p2 + _p3) * distance * distance * distance);
  }
}

class CatmullRomSpline2D<T extends num> extends CatmullRom<Point2D<double>> {
  final Point2D<T> _p0;
  final Point2D<T> _p1;
  final Point2D<T> _p2;
  final Point2D<T> _p3;

  CatmullRomSpline2D(this._p0, this._p1, this._p2, this._p3) {
    Validate.notNull(_p0);
    Validate.notNull(_p1);
    Validate.notNull(_p2);
    Validate.notNull(_p3);
  }

  CatmullRomSpline2D.noEndpoints(Point2D<T> p0, Point2D<T> p1)
      : _p0 = p0,
        _p1 = p0,
        _p2 = p1,
        _p3 = p1 {
    Validate.notNull(p0);
    Validate.notNull(p1);
  }

  @override
  Point2D<double> position(double distance) {
    Validate.inclusiveBetween(
        0, 1, distance, "Distance must be beteen 0 and 1 but was $distance");

    return new Point2D<double>(
        CatmullRomSpline<T>(_p0.x, _p1.x, _p2.x, _p3.x).position(distance),
        CatmullRomSpline<T>(_p0.y, _p1.y, _p2.y, _p3.y).position(distance));
  }
}
