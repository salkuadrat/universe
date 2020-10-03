export 'icon.dart';
export 'layer.dart';
export 'marker.dart';
export 'options.dart';

import 'package:flutter/widgets.dart';

import '../../core/core.dart';
import 'icon.dart';
import 'image.dart';

enum MarkerAlignment {
  top,
  left,
  right,
  bottom,
  center,
}

class MarkerOffset {
  final double top;
  final double left;

  MarkerOffset({this.top, this.left});
}

class Marker {
  final LatLng latlng;
  final double size;
  final double width;
  final double height;
  final double opacity;
  final MarkerAlignment align;
  final MarkerOffset offset;
  final MarkerIcon icon;
  final MarkerImage image;
  final Widget widget;
  final Function onTap;

  Marker({
    @required dynamic latlng, 
    num size, 
    num width, 
    num height, 
    this.opacity,
    this.align, 
    this.offset,
    this.icon,
    this.image,
    this.widget,
    this.onTap,
  }): 
    this.latlng = LatLng.from(latlng),
    this.size = size?.toDouble(),
    this.width = width?.toDouble() ?? size?.toDouble(),
    this.height = height?.toDouble() ?? size?.toDouble();
  
  bool get hasIcon => icon != null;
  bool get hasImage => image != null;

  factory Marker.from(dynamic value, {
    num size, 
    num width, 
    num height,
    num opacity,
    MarkerAlignment align,
    MarkerOffset offset,
    MarkerIcon icon,
    MarkerImage image,
    Widget widget,
    Function onTap,
  }) {
    if(value is Marker) return value;

    LatLng latlng;
    if(value is LatLng) {
      latlng = value;
    } else {
      latlng = LatLng.from(value);
    }

    return Marker(
      latlng: latlng, 
      size: size, 
      width: width, 
      height: height,
      opacity: opacity,
      align: align,
      offset: offset,
      icon: icon,
      image: image,
      widget: widget,
      onTap: onTap,
    );
  }
}