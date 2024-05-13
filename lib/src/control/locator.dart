import 'package:flutter/material.dart';

import '../layer/layer.dart';
import '../map/map.dart';

/// Map Locator Layer
class Locator extends MapLayer {
  /// Widget to be used as locator icon.
  final Widget? icon;

  /// Alignment of this locator layer.
  final Alignment alignment;

  /// Margin of this locator layer.
  final EdgeInsets margin;

  /// Target zoom level when locating user location.
  final double toZoom;

  const Locator({
    super.key,
    this.icon,
    this.alignment = Alignment.bottomRight,
    this.margin = const EdgeInsets.only(right: 20, bottom: 24),
    this.toZoom = 16,
  });

  @override
  Widget buildLayer(BuildContext context, MapState map) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: Container(
          margin: margin,
          width: 52,
          height: 52,
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.white,
              child: icon ??
                  Icon(
                    Icons.location_searching,
                    color: Colors.blueGrey[600],
                    size: 25,
                  ),
              onPressed: () {
                map.controller.locate(automove: true, toZoom: toZoom);
              },
            ),
          ),
        ),
      ),
    );
  }
}
