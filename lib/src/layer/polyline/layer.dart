import 'package:flutter/widgets.dart';
import 'package:universe/src/layer/polyline/options.dart';

import '../../core/geometry/latlng_bounds.dart';
import '../../core/geometry/point.dart';
import '../../core/latlng/latlng.dart';
import '../../layer/polyline/painter.dart';
import '../../map/controller/base.dart';
import '../../map/state.dart';
import '../base/layer.dart';
import 'marker.dart';

class PolylineLayer extends UniverseLayer {
  
  final PolylineLayerOptions options;

  const PolylineLayer({Key key, this.options}) 
    : super(key: key, options: options);

  @override 
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return LayoutBuilder(
      builder: (_, BoxConstraints c) {
        Size size = Size(c.maxWidth, c.maxHeight);
        Polyline polyline = options.polyline;
        polyline.bounds = LatLngBounds.from(polyline.positions);

        if(options.noClip && !polyline.bounds.isOverlapping(map.bounds)) {
          return Container();
        }

        polyline.offsets = _offsets(map, polyline.positions);

        return CustomPaint(
          painter: PolylinePainter(polyline),
          size: size,
        );
      },
    );
  }

  _offsets(MapState map, List<LatLng> positions) {
    List<Offset> offsets = [];

    for(LatLng position in positions) {
      UPoint pos = map.project(position);
      double scale = map.getZoomScale(map.zoom, map.zoom);
      pos = (pos * scale) - map.pixelOrigin;
      offsets.add(Offset(pos.x.toDouble(), pos.y.toDouble()));
      /* if (i > 0) {
        offsets.add(Offset(pos.x.toDouble(), pos.y.toDouble()));
      } */
    }

    return offsets;
  } 
}

class MultiPolylineLayer extends StatelessWidget {

  final MultiPolylineLayerOptions options;
  
  MultiPolylineLayer({Key key, this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for(Polyline polyline in options.polylines) PolylineLayer(
          options: PolylineLayerOptions(polyline, noClip: options.noClip),
        ),
      ],
    );
  }
}