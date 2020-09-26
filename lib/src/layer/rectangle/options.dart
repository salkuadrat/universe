import '../base/options.dart';
import 'marker.dart';

class RectangleLayerOptions extends LayerOptions {
  final Rectangle rectangle;

  const RectangleLayerOptions(this.rectangle);
}

class MultiRectangleLayerOptions extends LayerOptions {
  final List<Rectangle> rectangles;

  const MultiRectangleLayerOptions(this.rectangles);
}