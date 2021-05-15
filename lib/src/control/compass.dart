import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../layer/layer.dart';
import '../map/map.dart';

class Compass extends MapLayer {
  final Widget? icon;
  final Alignment alignment;
  final EdgeInsets margin;

  Compass({
    this.icon,
    this.alignment = Alignment.topRight,
    this.margin = const EdgeInsets.only(top: 52, right: 20),
  });

  @override
  Widget buildLayer(BuildContext context, MapStates map) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: Container(
          width: 40,
          height: 40,
          margin: margin,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () => map.controller.rotate(0.0, animate: true),
              backgroundColor: Colors.white,
              child: Transform.rotate(
                angle: map.angle,
                child: icon ??
                    SvgPicture.asset(
                      'packages/universe/assets/compass.svg',
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
