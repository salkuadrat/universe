import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

import '../../core/core.dart';
import '../../log.dart';
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
  final double? opacity;
  final double? rotation;
  final BoxFit? fit;
  final bool? gaplessPlayback;
  final dynamic data;
  final InteractiveLayerOptions? options;

  bool get isPath => imagePath != null && imagePath!.isNotEmpty;
  bool get isProvider => imageProvider != null;
  bool get isNetworkPath => isPath && (imagePath!.startsWith('http://') || imagePath!.startsWith('https://'));
  bool get isFilePath => isPath && File(imagePath!).existsSync();
  bool get isFile => imageFile != null;
  bool get isImage => image != null;

  ImageOverlay(dynamic image, {
    dynamic bounds, 
    this.imageError, 
    this.opacity, 
    this.rotation, 
    this.fit, 
    this.gaplessPlayback,
    this.data,
    this.options,
  }):
    assert((image is String || image is ImageProvider) && bounds != null),
    this.imagePath = image is String ? image : null,
    this.imageFile = image is File ? image : null,
    this.imageProvider = image is ImageProvider ? image : null,
    this.image = image is Image ? image : null,
    this.bounds = LatLngBounds.from(bounds),
    super(options: options);

  @override 
  Widget buildLayer(BuildContext context, MapController? controller, MapState map) {

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
    final opacity = this.opacity ?? 1.0;
    
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
          child: _image,
        ),
      ),
    );
  }

  Widget? get _image {
    final angle = degToRadian(rotation!);

    if(isImage) {
      return image;
    }
    
    if(isProvider) {
      return Transform.rotate(
        angle: angle,
        child: Image(
          image: imageProvider!,
          fit: fit,
          gaplessPlayback: gaplessPlayback!,
        ),
      );
    }

    if(isFile) {
      return Image.file(
        imageFile!,
        fit: fit, 
        gaplessPlayback: gaplessPlayback!
      );
    }

    if(isPath) {
      if(isNetworkPath) {
        return CachedNetworkImage(
          imageUrl: imagePath!,
          imageBuilder: (_, imageProvider) => Transform.rotate(
            angle: angle,
            child: Image(
              image: imageProvider,
              fit: fit,
              gaplessPlayback: gaplessPlayback!,
            ),
          ),
          placeholder: (_, __) => Container(),
          errorWidget: (_, __, ___) => imageError != null ? Image(image: imageError!) : Container(),
        );
      }

      if(isFilePath) {
        return Image.file(
          File(imagePath!),
          fit: fit, 
          gaplessPlayback: gaplessPlayback!
        );
      }

      try {
        return Image.asset(
          imagePath!, 
          fit: fit, 
          gaplessPlayback: gaplessPlayback!,
        );
      } catch (e) {
        log(e);
      }
    }
    
    if(imageError != null) {
      return Image(image: imageError!);
    }

    return Container();
  }
}