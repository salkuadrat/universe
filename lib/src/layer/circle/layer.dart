import 'package:flutter/widgets.dart';

import '../../core/geometry/point.dart';
import '../../core/latlng/distance/distance.dart';
import '../../core/latlng/latlng.dart';
import '../../map/map.dart';
import '../layer.dart';

class CircleLayer extends SingleLayer {
  
  final Circle circle;
  final List<Circle> circles;
  final CircleLayerOptions options;

  bool get hasCircle => circle != null;
  bool get hasCircles => circles != null && circles.isNotEmpty;
  
  // can accept a single circle or list of circles
  const CircleLayer(dynamic circle, {Key key, this.options}) : 
    assert(circle is Circle || (circle is List<Circle> && circle.length > 0)), 
    this.circle = circle is Circle ? circle : null,
    this.circles = circle is List<Circle> ? circle : const <Circle>[],
    super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return LayoutBuilder(
      builder: (_, BoxConstraints c) {
        Size size = Size(c.maxWidth, c.maxHeight);
        if(hasCircles) return _circles(map, size);
        if(hasCircle) return _circle(map, size, circle);
        return Container();
      },
    );
  }

  Widget _circles(MapState map, Size size) => Stack(
    children: [
      for(Circle circle in circles) _circle(map, size, circle),
    ],
  );

  Widget _circle(MapState map, Size size, Circle circle) {
    UPoint point = map.project(circle.latlng);
    double scale = map.getZoomScale(map.zoom, map.zoom);
    point = (point * scale) - map.pixelOrigin;
    circle.center = Offset(point.x, point.y);

    if(circle.isRadiusInMeter) {
      Distance D = Distance();
      LatLng r = D.offset(circle.latlng, circle.radius, 180);
      UPoint radius = map.project(r);
      radius = (radius * scale) - map.pixelOrigin;
      circle.radius = radius.y - point.y;
    }

    return CustomPaint(
      painter: CirclePainter(circle, options: options), 
      size: size,
    );
  }
}