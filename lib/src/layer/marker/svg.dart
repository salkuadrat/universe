import 'dart:io';

import 'package:flutter/material.dart';

class MarkerSvg {
  
  final File? svgFile;
  final String? svgPath;
  final Color? color;

  bool get isPath => svgPath != null && svgPath!.isNotEmpty;
  bool get isFile => svgFile != null;
  bool get isFilePath => isPath && File(svgPath!).existsSync();
  bool get isNetworkPath => isPath && (svgPath!.startsWith('http://') || svgPath!.startsWith('https://'));
  
  const MarkerSvg(dynamic svg, {
    this.color,
  }) :
    this.svgPath = svg is String ? svg : null,
    this.svgFile = svg is File ? svg : null;
  
}