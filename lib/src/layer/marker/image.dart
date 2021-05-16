import 'dart:io';

import 'package:flutter/material.dart';

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
      : this.imagePath = image is String ? image : null,
        this.imageFile = image is File ? image : null,
        this.imageProvider = image is ImageProvider ? image : null,
        this.image = image is Image ? image : null;
}
