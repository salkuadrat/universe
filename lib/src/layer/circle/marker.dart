import 'package:flutter/widgets.dart';

import '../../core/core.dart';

enum RadiusUnit {
  METER,
  PIXEL,
}

/// Circle can have their own style to override style from CircleLayerOptions.
///
/// This is to to handle the case when you use CirclesLayer
/// with many circle take their style from CirclesLayerOptions,
/// but small part of them need to have its own style.
///
/// Otherwise, it's better to use CircleLayerOptions to set circle style.
///
class Circle {
  final LatLng latlng;
  final double? radius;
  final RadiusUnit radiusUnit;
  final bool? stroke;
  final Color? strokeColor;
  final double? strokeWidth;
  final double? strokeOpacity;
  final StrokeCap? strokeCap;
  final StrokeJoin? strokeJoin;
  final bool? fill;
  final Color? fillColor;
  final double? fillOpacity;
  final dynamic data;

  LatLng get center => latlng;

  bool get isRadiusInMeter => radiusUnit == RadiusUnit.METER;
  bool get isRadiusInPixel => radiusUnit == RadiusUnit.PIXEL;

  Circle(
    dynamic latlng, {
    this.radius,
    this.radiusUnit = RadiusUnit.METER,
    this.stroke,
    this.strokeColor,
    this.strokeWidth,
    this.strokeOpacity,
    this.strokeCap,
    this.strokeJoin,
    this.fill,
    this.fillColor,
    this.fillOpacity,
    this.data,
  }) : this.latlng = LatLng.from(latlng);

  Circle copy({
    double? radius,
    RadiusUnit? radiusUnit,
    bool? stroke,
    Color? strokeColor,
    double? strokeWidth,
    double? strokeOpacity,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    bool? fill,
    Color? fillColor,
    double? fillOpacity,
    dynamic data,
  }) {
    return Circle(
      this.latlng,
      radius: radius ?? this.radius,
      radiusUnit: radiusUnit ?? this.radiusUnit,
      stroke: stroke ?? this.stroke,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      strokeOpacity: strokeOpacity ?? this.strokeOpacity,
      strokeCap: strokeCap ?? this.strokeCap,
      strokeJoin: strokeJoin ?? this.strokeJoin,
      fill: fill ?? this.fill,
      fillColor: fillColor ?? this.fillColor,
      fillOpacity: fillOpacity ?? this.fillOpacity,
      data: data ?? this.data,
    );
  }

  factory Circle.from(
    dynamic value, {
    double? radius,
    RadiusUnit? radiusUnit,
    bool? stroke,
    Color? strokeColor,
    double? strokeWidth,
    double? strokeOpacity,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    bool? fill,
    Color? fillColor,
    double? fillOpacity,
    dynamic data,
  }) {
    bool isCircle = value is Circle;
    bool isLatLng = value is LatLng;
    bool isCoordinate = value is List && value.first is num;

    assert(isCircle || isLatLng || isCoordinate);

    Circle circle = isCircle ? value : Circle(value);

    return circle.copy(
      radius: radius,
      radiusUnit: radiusUnit,
      stroke: stroke,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      strokeOpacity: strokeOpacity,
      strokeCap: strokeCap,
      strokeJoin: strokeJoin,
      fill: fill,
      fillColor: fillColor,
      fillOpacity: fillOpacity,
      data: data,
    );
  }

  @override
  String toString() => 'Circle($latlng, radius $radius)';
}
