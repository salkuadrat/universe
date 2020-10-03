import 'package:flutter/widgets.dart';

class Locator {

  final IconData icon;
  final Image image;
  final Alignment alignment;

  bool get hasIcon => icon != null;
  bool get hasImage => image != null;

  Locator({
    this.icon, 
    this.image, 
    this.alignment = Alignment.bottomRight,
  });

}