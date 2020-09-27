import '../../core/core.dart';

class VideoOverlay {
  
  final String videoUrl;
  final LatLngBounds bounds;
  final double opacity;
  final bool gaplessPlayback;

  VideoOverlay(this.videoUrl, dynamic bounds, {
    this.opacity,
    this.gaplessPlayback,
  }) : 
    assert(bounds != null),
    this.bounds = LatLngBounds.from(bounds);
  
  factory VideoOverlay.from(dynamic video, [dynamic bounds]) {
    if(video is VideoOverlay) return video;
    return VideoOverlay(video, bounds);
  }
}