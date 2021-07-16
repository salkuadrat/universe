import 'dart:io';
import 'dart:math' as math;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/core.dart';
import '../../log.dart';
import '../../map/map.dart';
import '../layer.dart';
import 'image.dart';

class MarkerLayer extends InteractiveLayer {
  final Marker? marker;
  final List<Marker> markers;
  final MarkerLayerOptions? options;

  bool get hasMarker => marker != null;
  bool get hasMarkers => markers.isNotEmpty;

  const MarkerLayer(
    dynamic marker, {
    Key? key,
    this.options,
  })  : assert(marker is Marker || marker is List<Marker>),
        this.marker = marker is Marker ? marker : null,
        this.markers = marker is List<Marker> ? marker : const <Marker>[],
        super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapState map) {
    if (hasMarkers) return _markers(context, map);
    if (hasMarker) return _marker(context, map, marker!);
    return Container();
  }

  Widget _markers(BuildContext context, MapState map) => Stack(
        children: [
          for (Marker marker in markers) _marker(context, map, marker),
        ],
      );

  Widget _marker(BuildContext context, MapState map, Marker marker) {
    double width = marker.width ?? options!.width!;
    double height = marker.height ?? options!.height!;
    double opacity = marker.opacity ?? options!.opacity;

    MarkerOffset? offset = marker.offset ?? options!.offset;
    MarkerAlignment align = marker.align ?? options!.align;

    if (offset == null) {
      offset = MarkerOffset(
        top: _topOffset(height, align),
        left: _leftOffset(width, align),
      );
    }

    double cleanWidth = width - offset.left!;
    double cleanHeight = height - offset.top!;

    if (_isOutOfBounds(map, marker, cleanWidth, cleanHeight)) {
      return Container();
    }

    double scale = map.getZoomScale(map.zoom, map.zoom);
    UPoint position = (map.project(marker.latlng) * scale) - map.pixelOrigin;

    double top = position.y - cleanHeight;
    double left = position.x - cleanWidth;

    return Positioned(
      width: width,
      height: height,
      left: left,
      top: top,
      child: Transform.rotate(
        angle: -map.angle,
        alignment: _rotateAlign(align),
        child: InteractiveGestureDetector(
          position: marker.latlng,
          data: marker.data,
          options: options,
          child: Opacity(
            opacity: opacity,
            child: _markerWidget(context, marker),
          ),
        ),
      ),
    );
  }

  Widget _markerWidget(BuildContext context, Marker marker) {
    ThemeData theme = Theme.of(context);

    MarkerSvg? svg = marker.svg ?? options!.svg;
    MarkerImage? image = marker.image ?? options!.image;
    MarkerIcon? icon = marker.icon ?? options!.icon;
    Widget? widget = marker.widget ?? options!.widget;

    double width = marker.width ?? options!.width!;
    double height = marker.height ?? options!.height!;

    if (icon != null) {
      return Icon(
        icon.icon,
        color: icon.color ?? theme.primaryColor,
        size: math.max(width, height),
      );
    }

    if (image != null) {
      if (image.isImage) {
        return image.image!;
      }

      if (image.isProvider) {
        return Image(
          image: image.imageProvider!,
          gaplessPlayback: true,
        );
      }

      if (image.isFile) {
        return Image.file(
          image.imageFile!,
          gaplessPlayback: true,
        );
      }

      if (image.isPath) {
        if (image.isNetworkPath) {
          return ExtendedImage.network(image.imagePath!,
              enableLoadState: false, gaplessPlayback: true);
        }

        if (image.isFilePath) {
          return Image.file(
            File(image.imagePath!),
            gaplessPlayback: true,
          );
        }

        try {
          return Image.asset(
            image.imagePath!,
            gaplessPlayback: true,
          );
        } catch (e) {
          log(e);
          return Container();
        }
      }
    }

    if (widget != null) {
      return widget;
    }

    if (svg != null) {
      if (svg.isFile) {
        return SvgPicture.file(
          svg.svgFile!,
          color: svg.color ?? theme.primaryColor,
        );
      }

      if (svg.isPath) {
        if (svg.isNetworkPath) {
          return SvgPicture.network(
            svg.svgPath!,
            color: svg.color ?? theme.primaryColor,
          );
        }

        if (svg.isFilePath) {
          return SvgPicture.file(
            File(svg.svgPath!),
            color: svg.color ?? theme.primaryColor,
          );
        }

        try {
          return SvgPicture.asset(
            svg.svgPath!,
            color: svg.color ?? theme.primaryColor,
          );
        } catch (e) {
          log(e);
        }
      }
    }

    return Container();
  }

  double _topOffset(num height, MarkerAlignment align) {
    switch (align) {
      case MarkerAlignment.top:
        return 0.0;
      case MarkerAlignment.bottom:
        return height as double;
      default:
        return height / 2;
    }
  }

  double _leftOffset(num width, MarkerAlignment align) {
    switch (align) {
      case MarkerAlignment.left:
        return 0.0;
      case MarkerAlignment.right:
        return width as double;
      default:
        return width / 2;
    }
  }

  Alignment _rotateAlign(MarkerAlignment align) {
    switch (align) {
      case MarkerAlignment.top:
        return Alignment.bottomCenter;
      case MarkerAlignment.bottom:
        return Alignment.topCenter;
      case MarkerAlignment.left:
        return Alignment.centerLeft;
      case MarkerAlignment.right:
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }

  bool _isInsideBounds(
      MapState map, Marker marker, double width, double height) {
    final markerPoint = map.project(marker.latlng);

    final sw = UPoint(markerPoint.x + width, markerPoint.y - height);
    final ne = UPoint(markerPoint.x - width, markerPoint.y + height);
    final markerBounds = Bounds(sw, ne);

    return map.pixelBounds.containsPartialBounds(markerBounds);
  }

  bool _isOutOfBounds(
      MapState map, Marker marker, double width, double height) {
    return !_isInsideBounds(map, marker, width, height);
  }
}
