import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../core/core.dart';
import '../layer.dart';

class Polygon extends Polyline {
  final bool? stroke;
  final Color? fillColor;
  final double? fillOpacity;
  final List<Color>? gradientFillColors;
  final List<double>? gradientFillStops;
  final List<List<LatLng>>? holes;
  final bool? withHoles;

  @override
  bool get isEmpty => latlngs.isEmpty;
  
  @override
  bool get isNotEmpty => latlngs.isNotEmpty;

  bool get isValid => isNotEmpty && latlngs.length > 2;
  bool get isNotValid => !isValid;

  @override
  LatLngBounds get bounds => LatLngBounds.from(latlngs);

  // can accept Polygon([LatLng(), LatLng(), ...]) or Polygon([[], [], ...])
  Polygon(
    List<dynamic> latlngs, {
    this.stroke,
    Color? strokeColor,
    double? strokeWidth,
    double? strokeOpacity,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    PathFillType? pathFillType,
    this.fillColor,
    this.fillOpacity,
    List<Color>? gradientStrokeColors,
    List<double>? gradientStrokeStops,
    this.gradientFillColors,
    this.gradientFillStops,
    bool? isDotted,
    this.holes = const [],
    this.withHoles,
    dynamic data,
  }) : super(
          latlngs,
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

  @override
  Polygon copy({
    bool? stroke,
    Color? strokeColor,
    num? strokeWidth,
    double? strokeOpacity,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    PathFillType? pathFillType,
    Color? fillColor,
    double? fillOpacity,
    List<Color>? gradientStrokeColors,
    List<double>? gradientStrokeStops,
    List<Color>? gradientFillColors,
    List<double>? gradientFillStops,
    List<List<LatLng>>? holes,
    bool? withHoles,
    bool? isDotted,
    dynamic data,
  }) {
    return Polygon(
      latlngs,
      stroke: stroke ?? this.stroke,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth as double? ?? this.strokeWidth,
      strokeOpacity: strokeOpacity ?? this.strokeOpacity,
      strokeCap: strokeCap ?? this.strokeCap,
      strokeJoin: strokeJoin ?? this.strokeJoin,
      pathFillType: pathFillType ?? this.pathFillType,
      fillColor: fillColor ?? this.fillColor,
      fillOpacity: fillOpacity ?? this.fillOpacity,
      gradientStrokeColors: gradientStrokeColors ?? this.gradientStrokeColors,
      gradientStrokeStops: gradientStrokeStops ?? this.gradientStrokeStops,
      gradientFillColors: gradientFillColors ?? this.gradientFillColors,
      gradientFillStops: gradientFillStops ?? this.gradientFillStops,
      holes: holes ?? this.holes,
      withHoles: withHoles ?? this.withHoles,
      isDotted: isDotted ?? this.isDotted,
      data: data ?? this.data,
    );
  }

  factory Polygon.from(
    dynamic value, {
    bool? stroke,
    Color? strokeColor,
    num? strokeWidth,
    double? strokeOpacity,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    Color? fillColor,
    double? fillOpacity,
    PathFillType? pathFillType,
    List<Color>? gradientStrokeColors,
    List<double>? gradientStrokeStops,
    List<Color>? gradientFillColors,
    List<double>? gradientFillStops,
    List<List<LatLng>>? holes,
    bool? withHoles,
    bool? isDotted,
    dynamic data,
  }) {
    bool isPolygon = value is Polygon;
    bool isList = value is List;
    bool isLatLngs = isList && value.first is LatLng;
    bool isCoordinates =
        isList && value.first is List && value.first.first is num;

    assert(isPolygon || isLatLngs || isCoordinates);

    Polygon polygon = isPolygon ? value : Polygon(value);

    return polygon.copy(
      stroke: stroke,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      strokeOpacity: strokeOpacity,
      strokeCap: strokeCap,
      strokeJoin: strokeJoin,
      fillColor: fillColor,
      fillOpacity: fillOpacity,
      pathFillType: pathFillType,
      gradientStrokeColors: gradientStrokeColors,
      gradientStrokeStops: gradientStrokeStops,
      gradientFillColors: gradientFillColors,
      gradientFillStops: gradientFillStops,
      holes: holes,
      withHoles: withHoles,
      isDotted: isDotted,
      data: data,
    );
  }

  @override
  String toString() => 'Polygon($latlngs)';
}
