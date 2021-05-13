import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../core/geometry/point.dart';
import '../../core/latlng/latlng.dart';
import '../../map/map.dart';
import '../layer.dart';

class PolylineLayer extends PathLayer {
  
  final Polyline? polyline;
  final List<Polyline> polylines;
  final PolylineLayerOptions? options;

  bool get hasPolyline => polyline != null;
  bool get hasPolylines => polylines.isNotEmpty;

  // can accept a single polyline or list of polylines
  PolylineLayer(dynamic polyline, {Key? key, this.options}) : 
    assert(polyline is Polyline || (polyline is List<Polyline> && polyline.length > 0)), 
    this.polyline = polyline is Polyline ? polyline : null,
    this.polylines = polyline is List<Polyline> ? polyline : const <Polyline>[],
    super(key: key, options: options);
  
  @override 
  Widget buildLayer(BuildContext context, MapController? controller, MapState map) {
    if(hasPolylines) return _polylines(context, map);
    if(hasPolyline) return _polyline(context, map, polyline);
    return Container();
  }

  Widget _polylines(BuildContext context, MapState map) => Stack(
    children: [
      for(Polyline polyline in polylines) _polyline(context, map, polyline),
    ],
  );

  Widget _polyline(BuildContext context, MapState map, Polyline? polyline) {
    if(options!.culling && polyline!.bounds.isNotOverlaps(map.bounds)) {
      return Container();
    }

    final strokeWidth = polyline!.strokeWidth ?? options!.strokeWidth;
    final primaryColor = Theme.of(context).primaryColor;
    final points = _points(map, polyline.latlngs);

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

    for(Offset point in points) {
      rPoints.add(Offset(point.dx - left, point.dy - top));
    }
    
    return Positioned(
      top: top,
      left: left,
      child: InteractiveGestureDetector(
        position: polyline.bounds,
        data: polyline.data,
        options: options,
        child: CustomPaint(
          painter: PolylinePainter(
            points: rPoints, 
            strokeColor: polyline.strokeColor ?? options!.strokeColor ?? primaryColor,
            strokeWidth: polyline.strokeWidth ?? options!.strokeWidth,
            strokeOpacity: polyline.strokeOpacity ?? options!.strokeOpacity,
            strokeCap: polyline.strokeCap ?? options!.strokeCap,
            strokeJoin: polyline.strokeJoin ?? options!.strokeJoin,
            pathFillType: polyline.pathFillType ?? options!.pathFillType,
            gradientStrokeColors: polyline.gradientStrokeColors ?? options!.gradientStrokeColors,
            gradientStrokeStops: polyline.gradientStrokeStops ?? options!.gradientStrokeStops,
            isDotted: polyline.isDotted ?? options!.isDotted,
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

  List<Offset> _points(MapState map, List<LatLng> latlngs) {
    List<Offset> points = [];

    for(LatLng latlng in latlngs) {
      double scale = map.getZoomScale(map.zoom, map.zoom);
      UPoint point = (map.project(latlng) * scale) -  map.pixelOrigin;
      points.add(Offset(point.x, point.y));
    }

    return points;
  }
}