import 'package:flutter/widgets.dart';
import 'tap_position.dart';

abstract class MapGestureMixin {

  void handleScaleStart(ScaleStartDetails details);

  void handleScaleUpdate(ScaleUpdateDetails details);

  void handleScaleEnd(ScaleEndDetails details);

  void handleTap(TapPosition position);

  void handleLongPress(TapPosition position);

  void handleDoubleTap(TapPosition tapPosition);

  void handleOnTapUp(TapUpDetails details);
  
}