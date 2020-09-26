import '../../layer/base/options.dart';
import 'marker.dart';

class CircleLayerOptions extends LayerOptions {
  final Circle circle;

  const CircleLayerOptions(this.circle);
}

class CirclesLayerOptions extends LayerOptions {
  final List<Circle> circles;
  
  const CirclesLayerOptions(this.circles);
}