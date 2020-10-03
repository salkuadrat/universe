import 'package:flutter/widgets.dart';

import '../../core/geometry/point.dart';
import '../../core/latlng/latlng.dart';
import '../../map/map.dart';
import '../layer.dart';

class PolylineLayer extends MapLayer {
  
  final Polyline polyline;
  final List<Polyline> polylines;
  final PolylineLayerOptions options;

  bool get hasPolyline => polyline != null;
  bool get hasPolylines => polylines != null && polylines.isNotEmpty;

  // can accept a single polyline or list of polylines
  const PolylineLayer(dynamic polyline, {Key key, this.options}) : 
    assert(polyline is Polyline || (polyline is List<Polyline> && polyline.length > 0)), 
    this.polyline = polyline is Polyline ? polyline : null,
    this.polylines = polyline is List<Polyline> ? polyline : const <Polyline>[],
    super(key: key, options: options);
  
  @override 
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return LayoutBuilder(
      builder: (_, BoxConstraints c) {
        Size size = Size(c.maxWidth, c.maxHeight);
        if(hasPolylines) return _polylines(map, size);
        if(hasPolyline) return _polyline(map, size, polyline);
        return Container();
      },
    );
  }

  Widget _polylines(MapState map, Size size) => Stack(
    children: [
      for(Polyline polyline in polylines) _polyline(map, size, polyline),
    ],
  );

  Widget _polyline(MapState map, Size size, Polyline polyline) {

    if(options.culling && polyline.bounds.isNotOverlaps(map.bounds)) {
      return Container();
    }

    final points = _points(map, polyline.latlngs);

    return CustomPaint(
      painter: PolylinePainter(polyline, points, options: options),
      size: size,
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