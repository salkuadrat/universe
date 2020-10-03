import 'package:flutter/widgets.dart';

import '../../core/geometry/point.dart';
import '../../core/latlng/latlng.dart';
import '../../map/map.dart';
import '../layer.dart';

class PolygonLayer extends MapLayer {

  final Polygon polygon;
  final List<Polygon> polygons;
  final PolygonLayerOptions options;

  bool get hasPolygon => polygon != null;
  bool get hasPolygons => polygons != null && polygons.isNotEmpty;

  // can accept a single polygon or list of polygons
  const PolygonLayer(dynamic polygon, {Key key, this.options}) : 
    assert(polygon is Polygon || (polygon is List<Polygon> && polygon.length > 0)), 
    this.polygon = polygon is Polygon ? polygon : null,
    this.polygons = polygon is List<Polygon> ? polygon : const <Polygon>[],
    super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return LayoutBuilder(
      builder: (_, BoxConstraints c) {
        Size size = Size(c.maxWidth, c.maxHeight);
        if(hasPolygons) return _polygons(map, size);
        if(hasPolygon) return _polygon(map, size, polygon);
        return Container();
      },
    );
  }

  Widget _polygons(MapState map, Size size) => Stack(
    children: [
      for(Polygon polygon in polygons) _polygon(map, size, polygon),
    ],
  );

  Widget _polygon(MapState map, Size size, Polygon polygon) {
    if(polygon.isNotValid) {
      return Container();
    }

    if(options.culling && polygon.bounds.isNotOverlaps(map.bounds)) {
      return Container();
    }

    final points = _points(map, polygon.latlngs);

    List<List<Offset>> holePointsList = [];
    
    if(polygon.holeLatLngList != null && polygon.holeLatLngList.isNotEmpty) {
      for(final holeLatLngs in polygon.holeLatLngList) {
        holePointsList.add(_points(map, holeLatLngs));
      }
    }

    return CustomPaint(
      painter: PolygonPainter(polygon, points, holePointsList, options: options),
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