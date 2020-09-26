import 'package:flutter/widgets.dart';
import 'package:universe/src/layer/circle/options.dart';

import '../../core/geometry/point.dart';
import '../../core/latlng/latlng.dart';
import '../../core/latlng/distance/distance.dart';
import '../../map/controller/base.dart';
import '../../map/state.dart';
import '../base/layer.dart';
import 'marker.dart';
import 'painter.dart';

class CircleLayer extends UniverseLayer {
  
  final CircleLayerOptions options;
  
  const CircleLayer({Key key, this.options}) 
    : super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return LayoutBuilder(
      builder: (_, BoxConstraints c) {
        Size size = Size(c.maxWidth, c.maxHeight);
        Circle circle = options.circle;

        GeoPoint point = map.project(circle.latlng);
        double scale = map.getZoomScale(map.zoom, map.zoom);
        point = (point * scale) - map.pixelCenterOrigin;
        circle.center = Offset(point.x, point.y);

        if(circle.isRadiusInMeter) {
          Distance D = Distance();
          LatLng r = D.offset(circle.latlng, circle.radius, 180);
          GeoPoint radius = map.project(r);
          radius = (radius * scale) - map.pixelCenterOrigin;
          circle.radius = radius.y - point.y;
        }

        return CustomPaint(
          painter: CirclePainter(circle, options: options), 
          size: size,
        );
      },
    );
  }
}

class CirclesLayer extends StatelessWidget {

  final CirclesLayerOptions options;
  
  const CirclesLayer({Key key, this.options}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for(Circle circle in options.circles) CircleLayer(
          options: CircleLayerOptions(circle),
        ),
      ],
    );
  }
}