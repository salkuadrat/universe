import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:video_player/video_player.dart';

import '../../map/map.dart';
import '../../core/core.dart';
import '../layer.dart';

class VideoOverlay extends InteractiveLayer {

  final String videoUrl;
  final LatLngBounds bounds;
  final dynamic data;
  final bool? looping;
  final InteractiveLayerOptions? options;
  final Function(VideoPlayerController?)? onReady;

  VideoOverlay(this.videoUrl, {
    Key? key, 
    dynamic bounds,
    this.data, 
    this.looping, 
    this.options,
    this.onReady,
  }) : this.bounds = LatLngBounds.from(bounds);

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

    return Positioned(
      top: top,
      left: left,
      width: width,
      height: height,
      child: InteractiveGestureDetector(
        position: bounds,
        data: data,
        options: options,
        child: VideoOverlayPlayer(
          videoUrl,
          bounds: bounds,
          looping: looping,
          options: options,
          data: data,
          onReady: onReady,
        ),
      ),
    );
  }
}

class VideoOverlayPlayer extends StatefulWidget {

  final String url;
  final LatLngBounds? bounds;
  final dynamic data;
  final bool? looping;
  final InteractiveLayerOptions? options;
  final Function(VideoPlayerController?)? onReady;

  VideoOverlayPlayer(this.url, {
    Key? key, 
    this.bounds,
    this.data, 
    this.looping, 
    this.options,
    this.onReady,
  });

  @override
  _VideoOverlayPlayerState createState() => _VideoOverlayPlayerState();
}

class _VideoOverlayPlayerState extends State<VideoOverlayPlayer> {

  MapStateManager get manager => context.cubit<MapStateManager>();
  MapState get map => manager.state;

  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.url);
    _videoController!.setLooping(widget.looping!);
    _videoController!.addListener(() => setState(() {}));
    _videoController!.initialize().then((_) => setState(() {
      widget.onReady?.call(_videoController);
    }));
    _videoController!.play();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _videoController!.value.aspectRatio,
      child: VideoPlayer(_videoController!),
    );
  }
}