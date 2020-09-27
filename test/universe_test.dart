import 'package:flutter_test/flutter_test.dart';
import 'package:universe/universe.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('LatLng', () {
    assert(LatLng(20.0, 18.0) == LatLng.from([20.0, 18.0]));
    assert(LatLng(20, 18.0) == LatLng.from([20.0, 18.0]));
    assert(LatLng(20.0, 18) == LatLng.from([20.0, 18.0]));
    assert(LatLng(20.0, 18.0) == LatLng.from([20, 18.0]));
    assert(LatLng(20.0, 18.0) == LatLng.from([20.0, 18]));
    assert(LatLng(20.0, 18.0, 50) == LatLng.from([20.0, 18.0, 50.0]));
    assert(LatLng(20.0, 18.0).toSexagesimal() == "20° 0' 0.00\" N, 18° 0' 0.00\" O");
    assert(LatLng(20.0, 18.0).toString() == "LatLng(Latitude:20.0, Longitude:18.0, Altitude:0.0)");
    assert(LatLng(20.0, 18.0, 40).toString() == "LatLng(Latitude:20.0, Longitude:18.0, Altitude:40.0)");
    assert(LatLng(20.2847773843, 18.74363727273).round(decimals: 4).toString() == "LatLng(Latitude:20.2848, Longitude:18.7436, Altitude:0.0)");
  });

  test('Size', () {
    assert(Size(20.0, 18.0) == Size.from([20.0, 18.0]));
    assert(Size(20, 18.0) == Size.from([20.0, 18.0]));
    assert(Size(20.0, 18) == Size.from([20.0, 18.0]));
    assert(Size(20.0, 18.0) == Size.from([20, 18.0]));
    assert(Size(20.0, 18.0) == Size.from([20.0, 18]));
    assert(Size(20, 18) * 0 == Size(0, 0));
    assert(Size(20, 18) * -1 == Size(-20, -18));
    assert(Size(20, 18) * 2 == Size(40, 36));
    assert(Size(20, 18) / 2 == Size(10, 9));
    assert(Size(20, 18) + Size(20, 18) == Size(40, 36));
    assert(Size(20, 18) - Size(20, 18) == Size(0, 0));
    expect(() => Size(20, 18) / 0, throwsA(isA<Exception>()));
  });

  test('UPoint', () {
    assert(UPoint(20.0, 18.0) == UPoint.from([20.0, 18.0]));
    assert(UPoint(20, 18.0) == UPoint.from([20.0, 18.0]));
    assert(UPoint(20.0, 18) == UPoint.from([20.0, 18.0]));
    assert(UPoint(20.0, 18.0) == UPoint.from([20, 18.0]));
    assert(UPoint(20.0, 18.0) == UPoint.from([20.0, 18]));
    assert(UPoint(20, 18) * 0 == UPoint(0, 0));
    assert(UPoint(20, 18) * -1 == UPoint(-20, -18));
    assert(UPoint(20, 18) * 2 == UPoint(40, 36));
    assert(UPoint(20, 18) / 2 == UPoint(10, 9));
    assert(UPoint(20, 18) + UPoint(20, 18) == UPoint(40, 36));
    assert(UPoint(20, 18) - UPoint(20, 18) == UPoint(0, 0));
    expect(() => UPoint(20, 18) / 0, throwsA(isA<Exception>()));
  });

  test('Bounds', () {
    assert(Bounds([20, 30], [50.0, 50.0]) == Bounds(UPoint(20.0, 30.0), UPoint(50, 50)));
    assert(Bounds([20, 30], [50, 50]).center == UPoint(35.0, 40.0));
    assert(Bounds([20, 30], [50, 50]).size == Size(30.0, 20.0));
    assert(Bounds([20, 30], [50, 50]).topLeft == UPoint(20.0, 30.0));
    assert(Bounds([20, 30], [50, 50]).topRight == UPoint(50.0, 30.0));
    assert(Bounds([20, 30], [50, 50]).bottomLeft == UPoint(20.0, 50.0));
    assert(Bounds([20, 30], [50, 50]).bottomRight == UPoint(50.0, 50.0));
    assert(Bounds([20, 30], [50, 50]).contains(UPoint(25, 40)) == true);
    assert(Bounds([20, 30], [50, 50]).contains(UPoint(80, 80)) == false);
    assert(Bounds([20, 30], [50, 50]).containsBounds(Bounds([25, 35], [40, 40])) == true);
    assert(Bounds([20, 30], [50, 50]).containsPartialBounds(Bounds([15, 25], [40, 80])) == true);
  });
}
