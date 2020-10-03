import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:universe/src/core/core.dart';

import '../../map/map.dart';
import '../layer.dart';
import 'image.dart';

class MarkerLayer extends MapLayer {

  final Marker marker;
  final List<Marker> markers;
  final MarkerLayerOptions options;

  bool get hasMarker => marker != null;
  bool get hasMarkers => markers != null && markers.isNotEmpty;

  const MarkerLayer(dynamic marker, {
    Key key, 
    this.options,
  }): 
    assert(marker is Marker || (marker is List<Marker> && marker.length > 0)), 
    this.marker = marker is Marker ? marker : null,
    this.markers = marker is List<Marker> ? marker : const <Marker>[],
    super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    if(hasMarkers) return _markers(map);
    if(hasMarker) return _marker(map, marker);
    return Container();
  }

  double _topOffset(num height, MarkerAlignment align) {
    switch (align) {
      case MarkerAlignment.top:
        return 0.0;
        break;
      case MarkerAlignment.bottom:
        return height;
      default:
        return height / 2;
    }
  }

  double _leftOffset(num width, MarkerAlignment align) {
    switch (align) {
      case MarkerAlignment.left:
        return 0.0;
        break;
      case MarkerAlignment.right:
        return width;
      default:
        return width / 2;
    }
  }

  bool _isInsideBounds(MapState map, Marker marker, double width, double height) {

    final markerPoint = map.project(marker.latlng);

    final sw = UPoint(markerPoint.x + width, markerPoint.y - height);
    final ne = UPoint(markerPoint.x - width, markerPoint.y + height);
    final markerBounds = Bounds(sw, ne);

    return map.pixelBounds.containsPartialBounds(markerBounds);
  }

  bool _isOutOfBounds(MapState map, Marker marker, double width, double height) {
    return !_isInsideBounds(map, marker, width, height);
  }

  Widget _markers(MapState map) => Stack(
    children: [
      for(Marker marker in markers) _marker(map, marker),
    ],
  );

  Widget _marker(MapState map, Marker marker) {

    double width = marker.width ?? options.width;
    double height = marker.height ?? options.height;
    double opacity = marker.opacity ?? options.opacity;

    MarkerOffset offset = marker.offset ?? options.offset;
    MarkerAlignment align = marker.align ?? options.align;

    if(offset == null) {
      offset = MarkerOffset(
        top: _topOffset(height, align),
        left: _leftOffset(width, align),
      );
    }

    double cleanWidth = width - offset.left;
    double cleanHeight = height - offset.top;

    if(_isOutOfBounds(map, marker, cleanWidth, cleanHeight)) {
      return Container();
    }

    double scale = map.getZoomScale(map.zoom, map.zoom);
    UPoint position = (map.project(marker.latlng) * scale) - map.pixelOrigin;

    double top = position.y - cleanHeight;
    double left = position.x - cleanWidth;

    MarkerImage image = marker.image ?? options.image;
    MarkerIcon icon = marker.icon ?? options.icon;
    
    return Positioned(
      width: width,
      height: height,
      left: left,
      top: top,
      child: GestureDetector(
        onTap: marker.onTap,
        child: Opacity(
          opacity: opacity,
          child: LayoutBuilder(
            builder: (_, __) {

              if(image != null && image.hasUrl) return CachedNetworkImage(
                imageUrl: image.url,
              );

              if(image != null && image.hasImage) return Image(
                image: image.image,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.medium,
              );

              if(icon != null) return Icon(
                icon.icon, 
                color: icon.color,
                size: math.max(width, height),
              );

              return Container();
            },
          ),
        ),
      ),
    );
  }
}