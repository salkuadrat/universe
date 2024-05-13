// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../map/map.dart';
import '../../core/core.dart';
import '../layer.dart';

class VideoOverlay extends InteractiveLayer {
  final String videoUrl;
  final LatLngBounds bounds;
  final dynamic data;
  final bool looping;
  final InteractiveLayerOptions options;
  final Function(VideoPlayerController?)? onReady;

  VideoOverlay(
    this.videoUrl, {
    Key? key,
    required dynamic bounds,
    this.data,
    this.looping = true,
    required this.options,
    this.onReady,
  })  : bounds = LatLngBounds.from(bounds),
        super(key: key);

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
  final LatLngBounds bounds;
  final dynamic data;
  final bool looping;
  final InteractiveLayerOptions options;
  final Function(VideoPlayerController?)? onReady;

  const VideoOverlayPlayer(
    this.url, {
    super.key,
    required this.bounds,
    this.data,
    required this.looping,
    required this.options,
    this.onReady,
  });

  @override
  State<VideoOverlayPlayer> createState() => _VideoOverlayPlayerState();
}

class _VideoOverlayPlayerState extends State<VideoOverlayPlayer> {
  MapState get map => Provider.of<MapState>(context, listen: false);

  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _videoController.setLooping(widget.looping);
    _videoController.addListener(() => setState(() {}));
    _videoController.initialize().then((_) => setState(() {
          widget.onReady?.call(_videoController);
        }));
    _videoController.play();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _videoController.value.aspectRatio,
      child: VideoPlayer(_videoController),
    );
  }
}
