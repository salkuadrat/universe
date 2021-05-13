import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../layer/layer.dart';
import '../map/map.dart';

class Locator extends MapLayer {

  final Widget? icon;
  final Alignment alignment;
  final EdgeInsets margin;
  final double toZoom;

  const Locator({
    this.icon, 
    this.alignment = Alignment.bottomRight,
    this.margin = const EdgeInsets.only(right: 20, bottom: 24),
    this.toZoom = 16,
  });

  @override 
  Widget buildLayer(BuildContext context, MapController? controller, MapState map) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: Container(
          margin: margin,
          width: 52, height: 52,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: icon ?? Icon(
                Icons.location_searching, 
                color: Colors.blueGrey[600], 
                size: 25,
              ),
              onPressed: () {
                controller!.locate(automove: true, toZoom: toZoom);
              },
            ),
          ),
        ),
      ),
    );
  }
}