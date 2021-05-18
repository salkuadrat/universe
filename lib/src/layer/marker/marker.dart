export 'icon.dart';
export 'image.dart';
export 'layer.dart';
export 'marker.dart';
export 'options.dart';
export 'svg.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../core/core.dart';
import 'icon.dart';
import 'image.dart';
import 'svg.dart';

enum MarkerAlignment {
  top,
  left,
  right,
  bottom,
  center,
}

class MarkerOffset {
  final double? top;
  final double? left;

  const MarkerOffset({this.top, this.left});
}

class Marker {
  final LatLng latlng;
  final double? size;
  final double? width;
  final double? height;
  final double? opacity;
  final MarkerAlignment? align;
  final MarkerOffset? offset;
  final MarkerIcon? icon;
  final MarkerImage? image;
  final MarkerSvg? svg;
  final Widget? widget;
  final dynamic data;

  Marker(
    dynamic latlng, {
    num? size,
    num? width,
    num? height,
    this.opacity,
    this.align,
    this.offset,
    dynamic widget,
    this.data,
  })  : this.latlng = LatLng.from(latlng),
        this.size = size?.toDouble(),
        this.width = width?.toDouble() ?? size?.toDouble(),
        this.height = height?.toDouble() ?? size?.toDouble(),
        this.icon = widget is MarkerIcon ? widget : null,
        this.image = widget is MarkerImage ? widget : null,
        this.svg = widget is MarkerSvg ? widget : null,
        this.widget = widget is Widget ? widget : null;

  bool get hasIcon => icon != null;
  bool get hasImage => image != null;
  bool get hasSvg => svg != null;

  factory Marker.from(
    dynamic value, {
    num? size,
    num? width,
    num? height,
    num? opacity,
    MarkerAlignment? align,
    MarkerOffset? offset,
    dynamic widget,
    dynamic data,
  }) {
    if (value is Marker)
      return Marker(
        value.latlng,
        size: size ?? value.size,
        width: width ?? value.width,
        height: height ?? value.height,
        opacity: opacity as double? ?? value.opacity,
        align: align ?? value.align,
        offset: offset ?? value.offset,
        widget:
            value.icon ?? value.image ?? value.svg ?? value.widget ?? widget,
        data: data ?? value.data,
      );

    bool isLatLng = value is LatLng;
    bool isList = (value is List &&
        value.isNotEmpty &&
        (value.first is int || value.first is double));

    if (isLatLng || isList) {
      LatLng latlng = value is LatLng ? value : LatLng.from(value);

      return Marker(
        latlng,
        size: size,
        width: width,
        height: height,
        opacity: opacity as double?,
        align: align,
        offset: offset,
        widget: widget,
        data: data,
      );
    }

    throw Exception("Invalid value...");
  }
}
