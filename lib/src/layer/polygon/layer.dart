import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../core/geometry/point.dart';
import '../../core/latlng/latlng.dart';
import '../../map/map.dart';
import '../layer.dart';

class PolygonLayer extends PathLayer {

  final Polygon? polygon;
  final List<Polygon> polygons;
  final PolygonLayerOptions? options;

  bool get hasPolygon => polygon != null;
  bool get hasPolygons => polygons.isNotEmpty;

  // can accept a single polygon or list of polygons
  const PolygonLayer(dynamic polygon, {Key? key, this.options}) : 
    assert(polygon is Polygon || (polygon is List<Polygon> && polygon.length > 0)), 
    this.polygon = polygon is Polygon ? polygon : null,
    this.polygons = polygon is List<Polygon> ? polygon : const <Polygon>[],
    super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapStates map) {
    if(hasPolygons) return _polygons(context, map);
    if(hasPolygon) return _polygon(context, map, polygon!);
    return Container();
  }

  Widget _polygons(BuildContext context, MapStates map) => Stack(
    children: [
      for(Polygon polygon in polygons) _polygon(context, map, polygon),
    ],
  );

  Widget _polygon(BuildContext context, MapStates map, Polygon polygon) {
    if(polygon.isNotValid) {
      return Container();
    }

    if(options!.culling && polygon.bounds.isNotOverlaps(map.bounds)) {
      return Container();
    }
    
    final strokeWidth = polygon.strokeWidth ?? options!.strokeWidth;
    final primaryColor = Theme.of(context).primaryColor;
    
    final points = _points(map, polygon.validLatLngs);
    final holesPoints = _holesPoints(map, polygon.holes);

    double minX = 0;
    double minY = 0;
    double maxX = 0;
    double maxY = 0;

    for(Offset point in points) {
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

    for(Offset point in points) {
      rPoints.add(Offset(point.dx - left, point.dy - top));
    }

    for(List<Offset> points in holesPoints) {
      List<Offset> _points = [];

      for(Offset point in points) {
        _points.add(Offset(point.dx - minX, point.dy - minY));
      }

      rHolesPoints.add(_points);
    }

    return Positioned(
      top: top,
      left: left,
      child: InteractiveGestureDetector(
        position: polygon.bounds,
        data: polygon.data,
        options: options,
        child: CustomPaint(
          painter: PolygonPainter(
            points: rPoints, 
            holesPoints: rHolesPoints, 
            stroke: polygon.stroke ?? options!.stroke,
            strokeColor: polygon.strokeColor ?? options!.strokeColor ?? 
              polygon.fillColor ?? options!.fillColor ?? primaryColor,
            strokeWidth: polygon.strokeWidth ?? options!.strokeWidth,
            strokeOpacity: polygon.strokeOpacity ?? options!.strokeOpacity,
            strokeCap: polygon.strokeCap ?? options!.strokeCap,
            strokeJoin: polygon.strokeJoin ?? options!.strokeJoin,
            pathFillType: polygon.pathFillType ?? options!.pathFillType,
            fillColor: polygon.fillColor ?? options!.fillColor ?? primaryColor,
            fillOpacity: polygon.fillOpacity ?? options!.fillOpacity,
            gradientStrokeColors: polygon.gradientStrokeColors ?? options!.gradientStrokeColors,
            gradientStrokeStops: polygon.gradientStrokeStops ?? options!.gradientStrokeStops,
            gradientFillColors: polygon.gradientFillColors ?? options!.gradientFillColors,
            gradientFillStops: polygon.gradientFillStops ?? options!.gradientFillStops,
            isDotted: polygon.isDotted ?? options!.isDotted,
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

  List<Offset> _points(MapStates map, List<LatLng?> latlngs) {
    List<Offset> points = [];

    for(LatLng? latlng in latlngs) {
      double scale = map.getZoomScale(map.zoom, map.zoom);
      UPoint point = (map.project(latlng) * scale) - map.pixelOrigin;
      points.add(Offset(point.x, point.y));
    }

    return points;
  }

  List<List<Offset>> _holesPoints(MapStates map, List<List<LatLng>>? holes) {
    List<List<Offset>> holesPoints = [];
    
    if(holes != null && holes.isNotEmpty) {
      for(List<LatLng> hole in holes) {
        holesPoints.add(_points(map, hole));
      }
    }

    return holesPoints;
  }
}