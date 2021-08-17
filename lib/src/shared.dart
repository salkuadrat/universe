import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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

/// Minimun velocity of fling gesture to make the map fling
const double kMinFlingVelocity = 800.0;

/// Converts degree to radian
double degToRadian(double deg) => deg * (PI / 180.0);

/// Radian to degree
double radianToDeg(double rad) => rad * (180.0 / PI);

/// Normalize the rotation value to be between -180 and +180 degrees
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

/// Parses string subdomain into a list of char subdomains.
List<String> parseSubdomains(dynamic subdomains) {
  if (subdomains is List<String>) return subdomains;
  if (subdomains is String) return subdomains.split('');
  return [];
}

/// Template pattern to be used for converting map tile url
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

/// wrap value to be inside the range
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

/// Calculate projected map size on the screen when it's rotated
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

/// Calculate projected point on the screen when the map is rotated
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
///
/// default opacity
const double opacityDef = 1.0;

/// default is paint stroke
const bool strokeDef = true;

/// default is paint stroke for Polygon
const bool strokePolygonDef = false;

/// default is paint stroke for Rectangle
const bool strokeRectangleDef = strokePolygonDef;

/// default stroke color
const Color strokeColorDef = Colors.lightBlue;

/// default stroke width
const double strokeWidthDef = 3.0;

/// default stroke width for Circle
const double strokeWidthCircleDef = 2.0;

/// default stroke width for Polygon
const double strokeWidthPolygonDef = 2.0;

/// default stroke width for Rectangle
const double strokeWidthRectangleDef = strokeWidthPolygonDef;

/// default stroke opacity
const double strokeOpacityDef = opacityDef;

/// default stroke opacity for Polygon
const double strokeOpacityPolygonDef = 0.9;

/// default stroke opacity for Rectangle
const double strokeOpacityRectangleDef = strokeOpacityPolygonDef;

/// default styles to use for stroke line endings
const StrokeCap strokeCapDef = StrokeCap.round;

/// default styles to use for stroke line segment joins
const StrokeJoin strokeJoinDef = StrokeJoin.round;

/// default is paint fill
const bool fillDef = true;

/// default is paint fill for Circle
const bool fillCircleDef = true;

/// default fill opacity
const double fillOpacityDef = 0.5;

/// default [PathFillType]
const PathFillType pathFillTypeDef = PathFillType.evenOdd;

/// default is stroke use dotted style
const bool isDottedDef = false;

/// default gradient colors
const List<Color> gradientColorsDef = [];

/// default gradient stops
const List<double> gradientStopsDef = [];

/// default smooth factor
const double smoothFactorDef = 1.0;

/// default is paint Polygon with holes
const bool withHolesDef = true;

/// default is culling
const bool cullingDef = true;

/// default interactive value
const bool interactiveDef = true;

/// default attribution
const String attributionDef = '';

/// default need to slide on boundaries
const bool slideOnBoundariesDef = false;

/// default is adaptive boundaries
const bool adaptiveBoundariesDef = false;

/// default tile size used at TileLayer
const double tileSizeDef = 256.0;

/// default zoom
const double zoomDef = 13.0;

/// default min zoom
const double minZoomDef = 0.0;

/// default max zoom
const double maxZoomDef = 18.0;

/// default delta changes of zoom
const double zoomDeltaDef = 1.0;

/// default initial rotation
const double rotationDef = 0.0;

/// default is rotation disabled
const bool disableRotationDef = false;

/// default show center marker
const bool showCenterMarkerDef = false;

/// default is live map
const bool liveDef = false;

/// default needs to move when live
const bool moveWhenLiveDef = true;

/// default is show locator
const bool showLocatorDef = true;

/// default is show location marker
const bool showLocationMarkerDef = false;

/// default is show location indicator
const bool showLocationIndicatorDef = false;

/// default is show compass
const bool showCompassDef = true;

/// default is show scale
const bool showScaleDef = true;

/// default is zoom changes needs to be reversed
const bool zoomReverseDef = false;

/// default zoom offset
const double zoomOffsetDef = 0.0;

/// default additional options for [TileLayerOptions]
const Map<String, dynamic> additionalOptionsDef = const <String, dynamic>{};

/// default subdomains for [TileLayer]
const List<String> subdomainsDef = const <String>['a', 'b', 'c'];

/// default number of buffer to keep
const int keepBufferDef = 2;

/// default tile opacity
const double tileOpacityDef = opacityDef;

/// default is update when zooming
const bool updateWhenZoomingDef = true;

/// default update tile interval
const int updateTileIntervalDef = 200;

/// default tile fade in duration
const int tileFadeInDurationDef = 50;

/// default tile fade in curve
const Curve tileFadeInCurveDef = Curves.easeOutQuint;

/// default tile fade in initial value
const double tileFadeInStartDef = 0.0;

/// default tile fade in initial value when override
const double tileFadeInStartWhenOverrideDef = 0.25;

/// default is override tiles when url changes
const bool overrideTilesWhenUrlChangesDef = true;

/// default Tile Provider
const TileProvider tileProviderDef = const NetworkRetryTileProvider();

/// default retina mode
const bool retinaModeDef = false;

/// default tms map
const bool tmsDef = false;

/// default hide attribution
const bool hideAttributionDef = false;

/// default overlay opacity
const double overlayOpacityDef = 0.75;

/// default overlay initial rotation
const double overlayRotationDef = 0.0;

/// default [BoxFit] type of overlay
const BoxFit overlayFitDef = BoxFit.contain;

/// default gapless playback of overlay
const bool overlayGaplessPlaybackDef = true;

/// default marker size
const double markerSizeDef = 42;

/// default marker local alignment
const MarkerAlignment markerAlignDef = MarkerAlignment.top;

/// default marker color
const Color markerColorDef = Colors.lightBlue;

/// default marker
const MarkerSvg markerDef =
    const MarkerSvg('packages/universe/assets/marker.svg');

/// default is looping playback of video overlay
const bool loopingVideoDef = true;

/// Attribution for OpenStreetMap
const String osmAttrDef = 'Map Data &copy; OpenStreetMap contributors';

const double zoomDiffToUpdateTiles = 0.6;
