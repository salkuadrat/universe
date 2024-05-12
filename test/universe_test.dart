// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:universe/src/shared.dart';
import 'package:universe/universe.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('LatLng', () {
    assert(LatLng(20.0, 18.0) == LatLng.from([20.0, 18.0]));
    assert(LatLng(20, 18.0) == LatLng.from([20.0, 18.0]));
    assert(LatLng(20.0, 18) == LatLng.from([20.0, 18.0]));
    assert(LatLng(20.0, 18.0) == LatLng.from([20, 18.0]));
    assert(LatLng(20.0, 18.0) == LatLng.from([20.0, 18]));
    assert(LatLng(10, 10) == LatLng(10.0, 10.0, 0.0));
    assert(LatLng(20.0, 18.0, 50) == LatLng.from([20.0, 18.0, 50.0]));
    assert(LatLng(20.0, 18.0).toSexagesimal() ==
        "20° 0' 0.00\" N, 18° 0' 0.00\" O");
    assert(LatLng(20.0, 18.0).toString() == "LatLng(20.0, 18.0, 0.0)");
    assert(LatLng(20.0, 18.0, 40).toString() == "LatLng(20.0, 18.0, 40.0)");
    assert(
        LatLng(20.2847773843, 18.74363727273).round(decimals: 4).toString() ==
            "LatLng(20.2848, 18.7436, 0.0)");
  });

  test('Size', () {
    assert(const Size(20.0, 18.0) == Size.from([20.0, 18.0]));
    assert(const Size(20, 18.0) == Size.from([20.0, 18.0]));
    assert(const Size(20.0, 18) == Size.from([20.0, 18.0]));
    assert(const Size(20.0, 18.0) == Size.from([20, 18.0]));
    assert(const Size(20.0, 18.0) == Size.from([20.0, 18]));
    assert(const Size(20, 18) * 0 == const Size(0, 0));
    //assert(Size(20, 18) * -1 == Size(-20, -18));
    assert(const Size(20, 18) * 2 == const Size(40, 36));
    assert(const Size(20, 18) / 2 == const Size(10, 9));
    assert(const Size(20, 18) + const Size(20, 18) == const Size(40, 36));
    assert(const Size(20, 18) - const Size(20, 18) == const Size(0, 0));
    expect(() => const Size(20, 18) / 0, throwsA(isA<Exception>()));
  });

  test('UPoint', () {
    assert(const UPoint(20.0, 18.0) == UPoint.from([20.0, 18.0]));
    assert(const UPoint(20, 18.0) == UPoint.from([20.0, 18.0]));
    assert(const UPoint(20.0, 18) == UPoint.from([20.0, 18.0]));
    assert(const UPoint(20.0, 18.0) == UPoint.from([20, 18.0]));
    assert(const UPoint(20.0, 18.0) == UPoint.from([20.0, 18]));
    assert(const UPoint(20, 18) * 0 == const UPoint(0, 0));
    assert(const UPoint(20, 18) * -1 == const UPoint(-20, -18));
    assert(const UPoint(20, 18) * 2 == const UPoint(40, 36));
    assert(const UPoint(20, 18) / 2 == const UPoint(10, 9));
    assert(const UPoint(20, 18) + const UPoint(20, 18) == const UPoint(40, 36));
    assert(const UPoint(20, 18) - const UPoint(20, 18) == const UPoint(0, 0));
    expect(() => const UPoint(20, 18) / 0, throwsA(isA<Exception>()));
  });

  test('Bounds', () {
    assert(Bounds([20, 30], [50.0, 50.0]) ==
        Bounds(const UPoint(20.0, 30.0), const UPoint(50, 50)));
    assert(Bounds([20, 30], [50, 50]).center == const UPoint(35.0, 40.0));
    assert(Bounds([20, 30], [50, 50]).size == const Size(30.0, 20.0));
    assert(Bounds([20, 30], [50, 50]).topLeft == const UPoint(20.0, 30.0));
    assert(Bounds([20, 30], [50, 50]).topRight == const UPoint(50.0, 30.0));
    assert(Bounds([20, 30], [50, 50]).bottomLeft == const UPoint(20.0, 50.0));
    assert(Bounds([20, 30], [50, 50]).bottomRight == const UPoint(50.0, 50.0));
    assert(Bounds([20, 30], [50, 50]).contains(const UPoint(25, 40)) == true);
    assert(Bounds([20, 30], [50, 50]).contains(const UPoint(80, 80)) == false);
    assert(
        Bounds([20, 30], [50, 50]).containsBounds(Bounds([25, 35], [40, 40])) ==
            true);
    assert(Bounds([20, 30], [50, 50])
            .containsPartialBounds(Bounds([15, 25], [40, 80])) ==
        true);
  });

  test('LatLngBounds', () {
    assert(LatLngBounds([20, 30], [50.0, 50.0]) ==
        LatLngBounds(LatLng(20.0, 30.0), LatLng(50, 50)));
    assert(LatLngBounds([
          [20, 30],
          [50.0, 50.0]
        ]) ==
        LatLngBounds(LatLng(20.0, 30.0), LatLng(50, 50)));
    assert(LatLngBounds([LatLng(20.0, 30.0), LatLng(50, 50)]) ==
        LatLngBounds(LatLng(20.0, 30.0), LatLng(50, 50)));
    assert(LatLngBounds.from([
          [20, 30],
          [50.0, 50.0]
        ]) ==
        LatLngBounds(LatLng(20.0, 30.0), LatLng(50, 50)));
  });

  test('Coordinates', () {
    assert(Coordinate(20.0, 18.0) == Coordinate.from([20.0, 18.0]));
    assert(Coordinate(20, 18.0) == Coordinate.from([20.0, 18.0]));
    assert(Coordinate(20.0, 18) == Coordinate.from([20.0, 18.0]));
    assert(Coordinate(20.0, 18.0) == Coordinate.from([20, 18.0]));
    assert(Coordinate(20.0, 18.0) == Coordinate.from([20.0, 18]));
    assert(Coordinate(20, 18) * 0 == Coordinate(0, 0));
    assert(Coordinate(20, 18) * -1 == Coordinate(-20, -18));
    assert(Coordinate(20, 18) * 2 == Coordinate(40, 36));
    assert(Coordinate(20, 18) / 2 == Coordinate(10, 9));
    assert(Coordinate(20, 18) + Coordinate(20, 18) == Coordinate(40, 36));
    assert(Coordinate(20, 18) - Coordinate(20, 18) == Coordinate(0, 0));
    expect(() => Coordinate(20, 18) / 0, throwsA(isA<Exception>()));
    assert(Coordinate(20.0, 18.0, 2) == Coordinate.from([20.0, 18.0, 2.0]));
    assert(Coordinate(20.0, 18.0, 2).key == '20.0:18.0:2.0');
  });

  /* test('Map State', () {
    MapStates map = MapStates(
      options: MapOptions(
        crs: CRS.EPSG3857,
        size: Size(480, 640),
        center: LatLng(120, 120),
        zoomOptions: ZoomOptions(
          zoom: 12.0, 
          minZoom: minZoomDef, 
          maxZoom: maxZoomDef,
        ),
        rotation: 0.0,
      ),
    );

    assert(map.crs is Epsg3857);
    assert(map.hasCenter == true);
    assert(map.hasRotation == false);
    assert(map.angle == 0.0);
    assert(map.width == 480);
    assert(map.height == 640);
    assert(map.halfSize == Size(240, 320));
    assert(map.halfPoint == UPoint(240, 320));
    assert(map.center == LatLng(120, 120));
    assert(map.zoom == 12.0112233);
    //assert(map.pixelOrigin == UPoint(873573.0, -320.0));
    assert(map.limitZoom(-10) == map.minZoom);
    assert(map.limitZoom(200) == map.maxZoom);
    assert(map.limitZoom(map.zoom) == map.zoom);
    assert(map.unproject(map.project(LatLng(10.5, 10.5)))!.equal(LatLng(10.5, 10.5)));
    assert(map.project(map.unproject(UPoint(10.5, 10.5))).equal(UPoint(10.5, 10.5)));
    assert(map.offsetToSize(Offset(200, 200)) == Size(200, 200));
    assert(map.sizeToOffset(Size(200, 200)) == Offset(200, 200));
    //print(map.getScaleZoom(map.getZoomScale(12, 15), 15));
    assert(map.getScaleZoom(map.getZoomScale(12, 15), 15) == 12.0);
    //print(map.getScaledZoom(12, 100));
  }); */

  test('projection', () {
    assert(projectedSize(const Size(240, 360), 0.0) == const Size(240, 360));
    print(projectedSize(const Size(240, 360), PI / 2));
    print(projectedSize(const Size(240, 360), PI / 4));
    print(projectedSize(const Size(240, 360), PI / 10));
    print(projectedSize(const Size(240, 360), PI / 18));
    print(projectedSize(const Size(240, 360), -PI / 18));
    print(projectedSize(const Size(240, 360), -PI / 10));
    print(projectedSize(const Size(240, 360), -PI / 4));
    print(projectedSize(const Size(240, 360), -PI / 2));

    print(projectedPoint(const Offset(0, 360), const Size(240, 360), PI / 2));
  });

  test('distance algorithms', () {
    Distance distance = const Distance();
    DistanceHaversine dh = DistanceHaversine();
    DistanceVincenty dv = DistanceVincenty();

    final from = [-6.170039, 106.8241];
    final to = [-6.181883, 106.826933];

    assert(distance(from, to) == dh(from, to));
    print(dv(from, to));
    print(dv.bearing(from, to));
    print(dv.offset(from, dv(from, to) as double?, dv.bearing(from, to)));
    assert(dv
        .offset(from, dv(from, to) as double?, dv.bearing(from, to))
        .equal(LatLng.from(to)));

    print(dh(from, to));
    print(dh.bearing(from, to));
    print(dh.offset(from, dh(from, to) as double?, dh.bearing(from, to)));
    assert(dh
        .offset(from, dh(from, to) as double?, dh.bearing(from, to))
        .equal(LatLng.from(to)));
  });
}
