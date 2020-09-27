import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

/// Equator radius in meter (WGS84 ellipsoid)
const double EQUATOR_RADIUS = 6378137.0;

/// Polar radius in meter (WGS84 ellipsoid)
const double POLAR_RADIUS = 6356752.314245;

/// WGS84
const double FLATTENING = 1 / 298.257223563;

/// Earth radius in meter
const double EARTH_RADIUS = EQUATOR_RADIUS;

/// The PI constant.
const double PI = math.pi;

const double kMinFlingVelocity = 800.0;

/// Converts degree to radian
double degToRadian(double deg) => deg * (PI / 180.0);

/// Radian to degree
double radianToDeg(double rad) => rad * (180.0 / PI);

/// Rounds [value] to given number of [decimals]
double round(double value, { int decimals: 6 })
    => (value * math.pow(10, decimals)).round() / math.pow(10, decimals);

/// Convert a bearing to be within the 0 to +360 degrees range.
/// Compass bearing is in the rangen 0° ... 360°
double normalizeBearing(double bearing) => (bearing + 360) % 360;

/// Converts a decimal coordinate value to sexagesimal format
///
/// String sex = decimal2sexagesimal(51.519475);
/// expect(sex, '51° 31\' 10.11"');
///
String decimal2sexagesimal(double decimal) {
  List<int> _split(double value) {
    // Force NumberFormat to create digit after comma 
    // if the value has no decimal point
    double roundedValue = round(value, decimals: 10);
    List<String> values = NumberFormat("0.0#####").format(roundedValue).split('.');
    return [ int.parse(values[0]).abs(), int.parse(values[1])];
  }

  List parts = _split(decimal);
  int degree = parts[0];
  int fraction = parts[1];

  double minutes = double.parse("0.$fraction") * 60;

  List minParts = _split(minutes);
  int minFraction = minParts[1];
  double seconds = (double.parse("0.$minFraction") * 60);
  seconds = round(seconds ,decimals: 2);

  return "$degree° ${minutes.floor()}' ${seconds.toStringAsFixed(2)}\"";
}

List<String> parseSubdomains(dynamic subdomains) {
  if(subdomains is List<String>) return subdomains;
  if(subdomains is String) return subdomains.split('');
  return [];
}

/// default parameter values
const bool strokeDef = true;
const double strokeWidthDef = 3.0;
const double strokeOpacityDef = 1.0;
const StrokeCap strokeCapDef = StrokeCap.round;
const StrokeJoin strokeJoinDef = StrokeJoin.round;
const double fillOpacityDef = 0.2;
const PathFillType fillTypeDef = PathFillType.evenOdd;
const bool isDottedDef = false;
const List<Color> gradientColorsDef = [];
const List<double> gradientStopsDef = [];
const double smoothFactorDef = 1.0;
const bool cullingDef = true;
const bool interactiveDef = true;
const String attributionDef = '';

const double tileSizeDef = 256.0;
const double minZoomDef = 0.0;
const double maxZoomDef = 18.0;
const bool zoomReverseDef = false;
const double zoomOffsetDef = 0.0;
const Map<String, String> additionalOptionsDef = const <String, String>{};
const List<String> subdomainsDef = const <String>['a', 'b', 'c'];
const int keepBufferDef = 2;
const double tileOpacityDef = 1.0;
const int updateTileIntervalDef = 200;
const int tileFadeInDurationDef = 100;
const double tileFadeInStartDef = 0.0;
const double tileFadeInStartWhenOverrideDef = 0.0;
const bool overrideTilesWhenUrlChangesDef = false;
const bool retinaModeDef = false;

const double overlayOpacityDef = 1.0;
const bool overlayGaplessPlaybackDef = false;