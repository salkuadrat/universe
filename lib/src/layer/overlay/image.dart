import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../core/core.dart';
import '../../map/map.dart';
import '../../shared.dart';
import '../layer.dart';

class ImageOverlay extends InteractiveLayer {
  final String? imagePath;
  final File? imageFile;
  final Image? image;
  final ImageProvider? imageProvider;
  final LatLngBounds bounds;
  final ImageProvider? imageError;
  final double opacity;
  final double rotation;
  final BoxFit fit;
  final bool gaplessPlayback;
  final dynamic data;

  bool get isPath => imagePath != null && imagePath!.isNotEmpty;
  bool get isProvider => imageProvider != null;
  bool get isNetworkPath =>
      isPath &&
      (imagePath!.startsWith('http://') || imagePath!.startsWith('https://'));
  bool get isFilePath => isPath && File(imagePath!).existsSync();
  bool get isAssetPath => isPath && imagePath!.startsWith('assets/');
  bool get isFile => imageFile != null;
  bool get isImage => image != null;

  ImageOverlay(dynamic image, {
    Key? key, 
    dynamic bounds,
    this.imageError,
    this.opacity = 1.0,
    this.rotation = 0.0,
    this.fit = BoxFit.cover,
    this.gaplessPlayback = true,
    this.data,
    InteractiveLayerOptions? options,
  })  : assert((image is String || image is ImageProvider) && bounds != null),
        imagePath = image is String ? image : null,
        imageFile = image is File ? image : null,
        imageProvider = image is ImageProvider ? image : null,
        image = image is Image ? image : null,
        bounds = LatLngBounds.from(bounds),
        super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapState map) {
    final pixelOrigin = map.pixelOrigin;
    final scale = map.getZoomScale(map.zoom, map.zoom);
    final nw = map.project(bounds.northWest);
    final se = map.project(bounds.southEast);

    final topLeft = (nw * scale) - pixelOrigin;
    final bottomRight = (se * scale) - pixelOrigin;

    final double top = topLeft.y;
    final double left = topLeft.x;
    final width = bottomRight.x - topLeft.x;
    final height = bottomRight.y - topLeft.y;

    return Positioned(
      top: top,
      left: left,
      width: width,
      height: height,
      child: Opacity(
        opacity: opacity,
        child: InteractiveGestureDetector(
          position: bounds,
          data: data,
          options: options,
          child: Transform.rotate(
            angle: degToRadian(rotation),
            child: _image,
          ),
        ),
      ),
    );
  }

  Widget? get _image {
    if (isImage) {
      return image;
    }

    if (isProvider) {
      return Image(
        image: imageProvider!,
        fit: fit,
        gaplessPlayback: gaplessPlayback,
      );
    }

    if (isFile) {
      return Image.file(
        imageFile!,
        fit: fit,
        gaplessPlayback: gaplessPlayback,
      );
    }

    if (isPath) {
      if (isNetworkPath) {
        return ExtendedImage.network(
          imagePath!,
          fit: fit,
          gaplessPlayback: gaplessPlayback,
          enableLoadState: false,
        );
      }

      if (isFilePath) {
        return Image.file(
          File(imagePath!),
          fit: fit,
          gaplessPlayback: gaplessPlayback,
        );
      }

      if (isAssetPath) {
        return Image.asset(
          imagePath!,
          fit: fit,
          gaplessPlayback: gaplessPlayback,
        );
      }
    }

    if (imageError != null) {
      return ExtendedImage(image: imageError!);
    }

    return Container();
  }
}
