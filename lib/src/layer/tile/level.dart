import '../../core/core.dart';

class Level {

  UPoint? origin;
  double? zoom;
  late double scale;
  double? zIndex;
  late UPoint translate;
  
  bool get hasOrigin => origin != null;

  Level();
}