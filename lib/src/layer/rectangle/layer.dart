import 'package:flutter/widgets.dart';

import '../../core/geometry/point.dart';
import '../../core/latlng/latlng.dart';
import '../../map/map.dart';
import '../layer.dart';

class RectangleLayer extends MapLayer {
  
  final Rectangle rectangle;
  final List<Rectangle> rectangles;
  final RectangleLayerOptions options;

  bool get hasRectangle => rectangle != null;
  bool get hasRectangles => rectangles != null && rectangles.isNotEmpty;

  // can accept a single rectangle or list of rectangles
  const RectangleLayer(dynamic rectangle, {Key key, this.options}) : 
    assert(rectangle is Rectangle || (rectangle is List<Rectangle> && rectangle.length > 0)), 
    this.rectangle = rectangle is Rectangle ? rectangle : null,
    this.rectangles = rectangle is List<Rectangle> ? rectangle : const <Rectangle>[],
    super(key: key, options: options);
  
  @override 
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return LayoutBuilder(
      builder: (_, BoxConstraints c) {
        Size size = Size(c.maxWidth, c.maxHeight);
        if(hasRectangles) return _rectangles(map, size);
        if(hasRectangle) return _rectangle(map, size, rectangle);
        return Container();
      },
    );
  }

  Widget _rectangles(MapState map, Size size) => Stack(
    children: [
      for(Rectangle rectangle in rectangles) _rectangle(map, size, rectangle),
    ],
  );

  Widget _rectangle(MapState map, Size size, Rectangle rectangle) {
    if(rectangle.isNotValid) {
      return Container();
    }
    
    if(options.culling && rectangle.bounds.isNotOverlaps(map.bounds)) {
      return Container();
    }

    final points = _points(map, rectangle.validLatLngs);

    List<List<Offset>> holePointsList = [];
    
    if(rectangle.holeLatLngList != null && rectangle.holeLatLngList.isNotEmpty) {
      for(final holeLatLngs in rectangle.holeLatLngList) {
        holePointsList.add(_points(map, holeLatLngs));
      }
    }

    return CustomPaint(
      painter: PolygonPainter(rectangle, points, holePointsList, options: options),
      size: size,
    );
  }

  List<Offset> _points(MapState map, List<LatLng> latlngs) {
    List<Offset> points = [];

    for(LatLng latlng in latlngs) {
      double scale = map.getZoomScale(map.zoom, map.zoom);
      UPoint point = (map.project(latlng) * scale) - map.pixelOrigin;
      points.add(Offset(point.x, point.y));
    }

    return points;
  }
}