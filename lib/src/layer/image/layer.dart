import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

import '../../map/map.dart';
import '../layer.dart';

class ImageOverlayLayer extends MapLayer {
  
  final ImageOverlay image;
  final List<ImageOverlay> images;
  final ImageOverlayOptions options;

  bool get hasImage => image != null;
  bool get hasImages => images != null && images.isNotEmpty;

  // can accept a single image or list of images
  const ImageOverlayLayer(dynamic image, {Key key, this.options}) : 
    assert(image is ImageOverlay || (image is List<ImageOverlay> && image.length > 0)),
    this.image = image is ImageOverlay ? image : null,
    this.images = image is List<ImageOverlay> ? image : const <ImageOverlay>[],
    super(key: key, options: options);
  
  @override 
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return ClipRect(
      child: LayoutBuilder(
        builder: (_, __) {
          if(hasImages) return _images(map);
          if(hasImage) return _image(map, image);
          return Container();
        },
      ),
    );
  }

  Widget _images(MapState map) => Stack(
    children: [
      for(ImageOverlay image in images) _image(map, image),
    ],
  );
  
  Widget _image(MapState map, ImageOverlay image) {
    final pixelOrigin = map.pixelOrigin;
    final scale = map.getZoomScale(map.zoom, map.zoom);
    final nw = map.project(image.bounds.northWest);
    final se = map.project(image.bounds.southEast);

    final topLeft = (nw * scale) - pixelOrigin;
    final bottomRight = (se * scale) - pixelOrigin;

    final top = topLeft.y;
    final left = topLeft.x;
    final width = bottomRight.x - topLeft.x;
    final height = bottomRight.y - topLeft.y;

    return Positioned(
      top: top,
      left: left,
      width: width,
      height: height,
      child: _renderImage(image),
    );
  }

  Widget _renderImage(ImageOverlay image) {
    if(image.hasProvider) {
      return Image(
        image: image.imageProvider,
        fit: BoxFit.fill,
        color: Color.fromRGBO(255, 255, 255, image.opacity),
        colorBlendMode: BlendMode.modulate,
        gaplessPlayback: image.gaplessPlayback,
      );
    }

    if(image.hasUrl) {
      return CachedNetworkImage(
        imageUrl: image.imageUrl,
        placeholder: (_, __) => Image(image: image.imagePlaceholder ?? options.imagePlaceholder),
        errorWidget: (_, __, ___) => Image(image: image.imageError ?? options.imageError),
      );
    }

    if(image.imageError != null || options.imageError != null) {
      return Image(image: image.imageError ?? options.imageError);
    }
    
    return Container();
  }
}