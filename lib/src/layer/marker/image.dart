import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MarkerImage {
  final String? imagePath;
  final File? imageFile;
  final ImageProvider? imageProvider;
  final Image? image;

  bool get isPath => imagePath != null && imagePath!.isNotEmpty;
  bool get isNetworkPath =>
      (imagePath!.startsWith('http://') || imagePath!.startsWith('https://'));
  bool get isFilePath => File(imagePath!).existsSync();

  bool get isFile => imageFile != null;
  bool get isProvider => imageProvider != null;
  bool get isImage => image != null;

  const MarkerImage(dynamic image)
      : imagePath = image is String ? image : null,
        imageFile = image is File ? image : null,
        imageProvider = image is ImageProvider ? image : null,
        image = image is Image ? image : null;
}
