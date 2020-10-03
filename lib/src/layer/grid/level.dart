import '../../core/core.dart';

class Level {

  UPoint origin;
  double zoom;
  double scale;
  double zIndex;
  UPoint translate;
  
  bool get hasOrigin => origin != null;

  Level();
}