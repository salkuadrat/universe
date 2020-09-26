enum AnchorAlign {
  top,
  left,
  right,
  bottom,
  center,
}

class Anchor {

  final double top;
  final double left;

  Anchor(this.top, this.left);

  Anchor._(double width, double height, AnchorAlign align)
    : top = _top(height, align), left = _left(width, align);
  
  static double _top(double height, AnchorAlign align) {
    switch(align) {
      case AnchorAlign.top:
        return 0.0;
      case AnchorAlign.bottom:
        return height;
      case AnchorAlign.left:
      case AnchorAlign.right:
      case AnchorAlign.center:
      default:
        return height / 2;
    }
  }

  static double _left(double width, AnchorAlign align) {
    switch(align) {
      case AnchorAlign.left:
        return 0.0;
      case AnchorAlign.right:
        return width;
      case AnchorAlign.top:
      case AnchorAlign.bottom:
      case AnchorAlign.center:
      default:
        return width / 2;
    }
  }
}