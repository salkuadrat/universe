
import 'package:flutter_test/flutter_test.dart';
import 'package:universe/src/core/latlng/latlng.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('latlng', () {
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
    //assert(LatLng(200, 10) == AssertionError('Latitude must be between -90 and 90 degrees. This value: 200.0'));
    //assert(LatLng(90, 200) == AssertionError('Longitude must be between -180 and 180 degrees. This value: 200.0'));
  });


}
