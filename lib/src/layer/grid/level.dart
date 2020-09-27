import '../../core/core.dart';

class Level {
  final double zIndex;
  final double zoom;
  final double scale;
  final UPoint origin;
  final UPoint translatePoint;

  Level({this.zIndex, this.zoom, this.scale, this.origin, this.translatePoint});
}