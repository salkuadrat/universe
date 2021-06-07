import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../core/geometry/point.dart';
import '../../core/latlng/latlng.dart';
import '../../map/map.dart';
import '../layer.dart';

class RectangleLayer extends ShapeLayer {
  final Rectangle? rectangle;
  final List<Rectangle> rectangles;
  final RectangleLayerOptions? options;

  bool get hasRectangle => rectangle != null;
  bool get hasRectangles => rectangles.isNotEmpty;

  // can accept a single rectangle or list of rectangles
  const RectangleLayer(dynamic rectangle, {Key? key, this.options})
      : assert(rectangle is Rectangle ||
            (rectangle is List<Rectangle> && rectangle.length > 0)),
        this.rectangle = rectangle is Rectangle ? rectangle : null,
        this.rectangles =
            rectangle is List<Rectangle> ? rectangle : const <Rectangle>[],
        super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapState map) {
    if (hasRectangles) return _rectangles(context, map);
    if (hasRectangle) return _rectangle(context, map, rectangle!);
    return Container();
  }

  Widget _rectangles(BuildContext context, MapState map) => Stack(
        children: [
          for (Rectangle rectangle in rectangles)
            _rectangle(context, map, rectangle),
        ],
      );

  Widget _rectangle(BuildContext context, MapState map, Rectangle rectangle) {
    if (rectangle.isNotValid) {
      return Container();
    }

    if (options!.culling && rectangle.bounds.isNotOverlaps(map.bounds)) {
      return Container();
    }

    final strokeWidth = rectangle.strokeWidth ?? options!.strokeWidth;
    final primaryColor = Theme.of(context).primaryColor;

    final points = _points(map, rectangle.validLatLngs);
    final holesPoints = _holesPoints(map, rectangle.holes);

    double minX = 0;
    double minY = 0;
    double maxX = 0;
    double maxY = 0;

    for (Offset point in points) {
      minX = minX == 0 ? point.dx : math.min(minX, point.dx);
      minY = minY == 0 ? point.dy : math.min(minY, point.dy);
      maxX = math.max(maxX, point.dx);
      maxY = math.max(maxY, point.dy);
    }

    final left = minX - strokeWidth;
    final top = minY - strokeWidth;
    final width = maxX - minX + (2 * strokeWidth);
    final height = maxY - minY + (2 * strokeWidth);

    List<Offset> rPoints = [];
    List<List<Offset>> rHolesPoints = [];

    for (Offset point in points) {
      rPoints.add(Offset(point.dx - left, point.dy - top));
    }

    for (List<Offset> points in holesPoints) {
      List<Offset> _points = [];

      for (Offset point in points) {
        _points.add(Offset(point.dx - minX, point.dy - minY));
      }

      rHolesPoints.add(_points);
    }

    return Positioned(
      top: top,
      left: left,
      child: InteractiveGestureDetector(
        position: rectangle.bounds,
        data: rectangle.data,
        options: options,
        child: CustomPaint(
          painter: PolygonPainter(
            points: rPoints,
            holesPoints: rHolesPoints,
            stroke: rectangle.stroke ?? options!.stroke,
            strokeColor: rectangle.strokeColor ??
                options!.strokeColor ??
                rectangle.fillColor ??
                options!.fillColor ??
                primaryColor,
            strokeWidth: rectangle.strokeWidth ?? options!.strokeWidth,
            strokeOpacity: rectangle.strokeOpacity ?? options!.strokeOpacity,
            strokeCap: rectangle.strokeCap ?? options!.strokeCap,
            strokeJoin: rectangle.strokeJoin ?? options!.strokeJoin,
            pathFillType: rectangle.pathFillType ?? options!.pathFillType,
            fillColor:
                rectangle.fillColor ?? options!.fillColor ?? primaryColor,
            fillOpacity: rectangle.fillOpacity ?? options!.fillOpacity,
            gradientStrokeColors:
                rectangle.gradientStrokeColors ?? options!.gradientStrokeColors,
            gradientStrokeStops:
                rectangle.gradientStrokeStops ?? options!.gradientStrokeStops,
            gradientFillColors:
                rectangle.gradientFillColors ?? options!.gradientFillColors,
            gradientFillStops:
                rectangle.gradientFillStops ?? options!.gradientFillStops,
            isDotted: rectangle.isDotted ?? options!.isDotted,
            culling: options!.culling,
          ),
          child: Container(
            width: width,
            height: height,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  List<Offset> _points(MapState map, List<LatLng?> latlngs) {
    List<Offset> points = [];

    for (LatLng? latlng in latlngs) {
      double scale = map.getZoomScale(map.zoom, map.zoom);
      UPoint point = (map.project(latlng) * scale) - map.pixelOrigin;
      points.add(Offset(point.x, point.y));
    }

    return points;
  }

  List<List<Offset>> _holesPoints(MapState map, List<List<LatLng>>? holes) {
    List<List<Offset>> holesPoints = [];

    if (holes != null && holes.isNotEmpty) {
      for (final hole in holes) {
        holesPoints.add(_points(map, hole));
      }
    }

    return holesPoints;
  }
}
