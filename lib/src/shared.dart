import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'core/core.dart';
import 'layer/layer.dart';

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

double normalizeDeg(double deg) {
  deg = deg % 360.0;

  if (deg > 180.0) {
    deg = deg - 360.0;
  }

  return deg;
}

/// Rounds [value] to given number of [decimals]
double round(double value, {int decimals: 6}) =>
    (value * math.pow(10, decimals)).round() / math.pow(10, decimals);

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
    List<String> values =
        NumberFormat("0.0#####").format(roundedValue).split('.');
    return [int.parse(values[0]).abs(), int.parse(values[1])];
  }

  List parts = _split(decimal);
  int degree = parts[0];
  int fraction = parts[1];

  double minutes = double.parse("0.$fraction") * 60;

  List minParts = _split(minutes);
  int minFraction = minParts[1];
  double seconds = (double.parse("0.$minFraction") * 60);
  seconds = round(seconds, decimals: 2);

  return "$degree° ${minutes.floor()}' ${seconds.toStringAsFixed(2)}\"";
}

List<String> parseSubdomains(dynamic subdomains) {
  if (subdomains is List<String>) return subdomains;
  if (subdomains is String) return subdomains.split('');
  return [];
}

final _templatePattern = RegExp(r'\{ *([\w_-]+) *\}');

/// Replaces the templating placeholders with the provided data map.
///
/// Throws an [Exception] if any placeholder remains unresolved.
String urlFromTemplate(String str, Map<String, dynamic> data) {
  return str.replaceAllMapped(_templatePattern, (Match match) {
    var value = data[match.group(1)!];
    if (value == null) {
      throw Exception('No value provided for variable ${match.group(1)}');
    } else {
      return value;
    }
  });
}

double wrap(double value, List<num>? range, [bool includeMax = false]) {
  if (range == null || range.length != 2) {
    return value;
  }

  final min = math.min(range[0], range[1]);
  final max = math.max(range[0], range[1]);
  final d = max - min;

  if (value == max && includeMax) {
    return value;
  }

  return ((value - min) % d + d) % d + min;
}

Size projectedSize(Size size, double angle) {
  if (angle == 0.0) {
    return size;
  }

  final oWidth = size.width;
  final oHeight = size.height;

  final rad90 = PI / 2;
  final sinangle = math.sin(angle).abs();
  final sinrest = math.sin(rad90 - angle).abs();

  final width = (oWidth * sinrest) + (oHeight * sinangle) + 20;
  final height = (oHeight * sinrest) + (oWidth * sinangle) + 20;

  return Size(width, height).round();
}

Offset projectedPoint(Offset point, Size size, double angle) {
  if (angle == 0.0) {
    return point;
  }

  Size nSize = projectedSize(size, angle);
  Size halfSize = size / 2;

  Offset pointFromCenter = Offset(
    point.dx - halfSize.width,
    halfSize.height - point.dy,
  );

  final cos = math.cos(-angle);
  final sin = math.sin(-angle);
  final pcx = pointFromCenter.dx;
  final pcy = pointFromCenter.dy;

  pointFromCenter = Offset(
    pcx * cos + pcy * sin,
    pcy * cos - pcx * sin,
  );

  Size sizeOffset = (nSize - size) / 2;

  final x = halfSize.width + pointFromCenter.dx + sizeOffset.x;
  final y = halfSize.height - pointFromCenter.dy + sizeOffset.y;

  return Offset(x, y);
}

/// default parameter values
const double opacityDef = 1.0;

const bool strokeDef = true;
const bool strokePolygonDef = false;
const bool strokeRectangleDef = strokePolygonDef;
const Color strokeColorDef = Colors.lightBlue;
const double strokeWidthDef = 3.0;
const double strokeWidthCircleDef = 2.0;
const double strokeWidthPolygonDef = 2.0;
const double strokeWidthRectangleDef = strokeWidthPolygonDef;
const double strokeOpacityDef = opacityDef;
const double strokeOpacityPolygonDef = 0.9;
const double strokeOpacityRectangleDef = strokeOpacityPolygonDef;
const StrokeCap strokeCapDef = StrokeCap.round;
const StrokeJoin strokeJoinDef = StrokeJoin.round;
const bool fillDef = true;
const bool fillCircleDef = true;
const double fillOpacityDef = 0.5;
const PathFillType pathFillTypeDef = PathFillType.evenOdd;
const bool isDottedDef = false;
const List<Color> gradientColorsDef = [];
const List<double> gradientStopsDef = [];
const double smoothFactorDef = 1.0;
const bool withHolesDef = true;
const bool cullingDef = true;
const bool interactiveDef = true;
const String attributionDef = '';
const bool slideOnBoundariesDef = false;
const bool adaptiveBoundariesDef = false;

const double tileSizeDef = 256.0;
const double zoomDef = 13.0;
const double minZoomDef = 0.0;
const double maxZoomDef = 18.0;
const double zoomDeltaDef = 1.0;
const double rotationDef = 0.0;
const bool disableRotationDef = false;
const bool showCenterMarkerDef = false;
const bool liveDef = false;
const bool moveWhenLiveDef = true;
const bool showLocatorDef = true;
const bool showLocationMarkerDef = false;
const bool showLocationIndicatorDef = false;
const bool showCompassDef = true;
const bool showScaleDef = true;
const bool zoomReverseDef = false;
const double zoomOffsetDef = 0.0;
const Map<String, dynamic> additionalOptionsDef = const <String, dynamic>{};
const List<String> subdomainsDef = const <String>['a', 'b', 'c'];
const int keepBufferDef = 2;
const double tileOpacityDef = opacityDef;
const bool updateWhenZoomingDef = true;
const int updateTileIntervalDef = 50;
const int tileFadeInDurationDef = 50;
const Curve tileFadeInCurveDef = Curves.easeInOut;
const double tileFadeInStartDef = 0.0;
const double tileFadeInStartWhenOverrideDef = 0.0;
const bool overrideTilesWhenUrlChangesDef = false;
const TileProvider tileProviderDef = const CachedNetworkTileProvider();
const bool retinaModeDef = false;
const bool tmsDef = false;
const bool hideAttributionDef = false;

const double overlayOpacityDef = 0.75;
const double overlayRotationDef = 0.0;
const BoxFit overlayFitDef = BoxFit.contain;
const bool overlayGaplessPlaybackDef = false;

const double markerSizeDef = 42;
const MarkerAlignment markerAlignDef = MarkerAlignment.top;

const Color markerColorDef = Colors.lightBlue;

const MarkerSvg markerDef =
    const MarkerSvg('packages/universe/assets/marker2.svg');

const bool loopingVideoDef = true;
