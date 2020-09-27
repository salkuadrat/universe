import 'package:flutter/rendering.dart';

import 'rectangle.dart';

/// use PolygonPainter to paint Rectangle
class RectanglePainter extends CustomPainter {

  final Rectangle rectangle;
  final RectangleLayerOptions options;

  RectanglePainter(this.rectangle, {this.options});

  @override
  void paint(Canvas canvas, Size size) {

  }

  @override
  bool shouldRepaint(RectanglePainter oldPainter) => false;

}