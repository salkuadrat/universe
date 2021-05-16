import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:video_player/video_player.dart';

import '../shared.dart';

class VideoOverlayMap extends StatefulWidget {
  @override
  _VideoOverlayMapState createState() => _VideoOverlayMapState();
}

class _VideoOverlayMapState extends State<VideoOverlayMap> {
  VideoPlayerController? _videoController;

  void _toggleVideo() {
    if (_videoController != null && _videoController!.value.isInitialized) {
      if (_videoController!.value.isPlaying) {
        _videoController?.pause();
      } else {
        _videoController?.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      type: MapBoxType.Satellite,
      accessToken: yourAccessTokenHere,
      center: [23.358295, -114.351456],
      zoom: 4,
      scale: Scale(color: Colors.white),
      videos: [
        U.VideoOverlay(
          'https://www.mapbox.com/bites/00188/patricia_nasa.mp4',
          bounds: [
            [32, -130],
            [13, -100]
          ],
          onReady: (controller) => (_videoController = controller),
          onTap: (position, data) => _toggleVideo(),
        ),
      ],
    );
  }
}
