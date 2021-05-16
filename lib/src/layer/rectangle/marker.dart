import 'package:flutter/rendering.dart';

import '../../core/core.dart';
import '../layer.dart';

class Rectangle extends Polygon {
  bool get isEmpty => latlngs.isEmpty;
  bool get isNotEmpty => latlngs.isNotEmpty;

  bool get isValid =>
      isNotEmpty && latlngs.length == 2 && latlngs[0] != latlngs[1];

  bool get isNotValid => !isValid;

  LatLngBounds get bounds => LatLngBounds.from(latlngs);

  List<LatLng?> get validLatLngs {
    LatLngBounds bounds = this.bounds;
    return [
      bounds.northWest,
      bounds.northEast,
      bounds.southEast,
      bounds.southWest,
      bounds.northWest,
    ];
  }

  Rectangle(
    List<dynamic> latlngs, {
    bool? stroke,
    Color? strokeColor,
    double? strokeWidth,
    double? strokeOpacity,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    PathFillType? pathFillType,
    Color? fillColor,
    double? fillOpacity,
    bool? isDotted,
    List<Color>? gradientStrokeColors,
    List<double>? gradientStrokeStops,
    List<Color>? gradientFillColors,
    List<double>? gradientFillStops,
    List<List<LatLng>>? holes,
    bool? withHoles,
    dynamic data,
  }) : super(
          latlngs,
          stroke: stroke,
          strokeColor: strokeColor,
          strokeWidth: strokeWidth,
          strokeOpacity: strokeOpacity,
          strokeCap: strokeCap,
          strokeJoin: strokeJoin,
          pathFillType: pathFillType,
          fillColor: fillColor,
          fillOpacity: fillOpacity,
          isDotted: isDotted,
          gradientStrokeColors: gradientStrokeColors,
          gradientStrokeStops: gradientStrokeStops,
          gradientFillColors: gradientFillColors,
          gradientFillStops: gradientFillStops,
          holes: holes,
          withHoles: withHoles,
          data: data,
        ) {
    assert(latlngs.length == 2);
  }

  Rectangle copy({
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
    return Rectangle(
      this.latlngs,
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

  factory Rectangle.from(
    dynamic value, {
    bool? stroke,
    Color? strokeColor,
    double? strokeWidth,
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
    bool isRectangle = value is Rectangle;
    bool isList = value is List;
    bool isLatLngs = isList && value.first is LatLng;
    bool isCoordinates =
        isList && value.first is List && value.first.first is num;

    assert(isRectangle || isLatLngs || isCoordinates);

    Rectangle rectangle = isRectangle ? value : Rectangle(value);

    return rectangle.copy(
      stroke: stroke,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      strokeOpacity: strokeOpacity,
      strokeCap: strokeCap,
      strokeJoin: strokeJoin,
      pathFillType: pathFillType,
      fillColor: fillColor,
      fillOpacity: fillOpacity,
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
  String toString() => 'Rectangle($latlngs)';
}
