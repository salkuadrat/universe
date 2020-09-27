import 'package:flutter/widgets.dart';

import '../../map/map.dart';
import '../layer.dart';

class VideoOverlayLayer extends SingleLayer {
  
  final VideoOverlay video;
  final List<VideoOverlay> videos;
  final VideoOverlayOptions options;

  bool get hasVideo => video != null;
  bool get hasVideos => videos != null && videos.isNotEmpty;

  const VideoOverlayLayer(dynamic video, {Key key, this.options}) : 
    assert(video is VideoOverlay || (video is List<VideoOverlay> && video.length > 0)),
    this.video = video is VideoOverlay ? video : null,
    this.videos = video is List<VideoOverlay> ? video : const <VideoOverlay>[],
    super(key: key, options: options);
  
  @override 
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return ClipRect(
      child: LayoutBuilder(
        builder: (_, __) {
          if(hasVideos) return _videos(map);
          if(hasVideo) return _video(map, video);
          return Container();
        },
      ),
    );
  }

  Widget _videos(MapState map) => Stack(
    children: [
      for(VideoOverlay video in videos) _video(map, video),
    ],
  );

  Widget _video(MapState map, VideoOverlay video) {
    final pixelOrigin = map.pixelOrigin;
    final scale = map.getZoomScale(map.zoom, map.zoom);
    final nw = map.project(video.bounds.northWest);
    final se = map.project(video.bounds.southEast);

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
      child: VideoContainer(
        map: map,
        video: video,
        options: options,
      ),
    );
  }
}

class VideoContainer extends StatelessWidget {

  final MapState map;
  final VideoOverlay video;
  final VideoOverlayOptions options;

  VideoContainer({Key key, this.map, this.video, this.options}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}