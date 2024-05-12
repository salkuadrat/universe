import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../core/core.dart';

class Polyline {
  final List<LatLng> latlngs;
  final Color? strokeColor;
  final double? strokeWidth;
  final double? strokeOpacity;
  final StrokeCap? strokeCap;
  final StrokeJoin? strokeJoin;
  final PathFillType? pathFillType;
  final List<Color>? gradientStrokeColors;
  final List<double>? gradientStrokeStops;
  final bool? isDotted;
  final dynamic data;

  bool get isEmpty => latlngs.isEmpty;
  bool get isNotEmpty => latlngs.isNotEmpty;

  LatLngBounds get bounds => LatLngBounds.from(latlngs);

  List<LatLng?> get validLatLngs {
    if (latlngs.first == latlngs.last) {
      return latlngs;
    }

    return [...latlngs, latlngs.first];
  }

  // can accept Polyline([LatLng(), LatLng(), ...]) or Polygon([[], [], ...])
  Polyline(
    List<dynamic> latlngs, {
    this.strokeColor,
    this.strokeWidth,
    this.strokeOpacity,
    this.strokeCap,
    this.strokeJoin,
    this.pathFillType,
    this.gradientStrokeColors,
    this.gradientStrokeStops,
    this.isDotted,
    this.data,
  }) : latlngs = latlngs.map((latlng) => LatLng.from(latlng)).toList();

  Polyline copy({
    Color? strokeColor,
    num? strokeWidth,
    double? strokeOpacity,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    PathFillType? pathFillType,
    List<Color>? gradientStrokeColors,
    List<double>? gradientStrokeStops,
    bool? isDotted,
    dynamic data,
  }) {
    return Polyline(
      latlngs,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth as double? ?? this.strokeWidth,
      strokeOpacity: strokeOpacity ?? this.strokeOpacity,
      strokeCap: strokeCap ?? this.strokeCap,
      strokeJoin: strokeJoin ?? this.strokeJoin,
      pathFillType: pathFillType ?? this.pathFillType,
      gradientStrokeColors: gradientStrokeColors ?? this.gradientStrokeColors,
      gradientStrokeStops: gradientStrokeStops ?? this.gradientStrokeStops,
      isDotted: isDotted ?? this.isDotted,
      data: data ?? this.data,
    );
  }

  factory Polyline.from(
    dynamic value, {
    Color? strokeColor,
    num? strokeWidth,
    double? strokeOpacity,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    PathFillType? pathFillType,
    List<Color>? gradientStrokeColors,
    List<double>? gradientStrokeStops,
    bool? isDotted,
    dynamic data,
  }) {
    bool isPolyline = value is Polyline;
    bool isList = value is List;
    bool isLatLngs = isList && value.first is LatLng;
    bool isCoordinates =
        isList && value.first is List && value.first.first is num;

    assert(isPolyline || isLatLngs || isCoordinates);

    Polyline polyline = isPolyline ? value : Polyline(value);

    return polyline.copy(
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      strokeOpacity: strokeOpacity,
      strokeCap: strokeCap,
      strokeJoin: strokeJoin,
      pathFillType: pathFillType,
      gradientStrokeColors: gradientStrokeColors,
      gradientStrokeStops: gradientStrokeStops,
      isDotted: isDotted,
      data: data,
    );
  }

  @override
  String toString() => 'Polyline($latlngs)';
}
