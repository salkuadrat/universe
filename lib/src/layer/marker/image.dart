import 'package:flutter/painting.dart';

class MarkerImage {

  final String url;
  final String asset;
  final ImageProvider image;

  bool get hasUrl => url != null && url.isNotEmpty;
  bool get hasImage => image != null;

  const MarkerImage({this.url, this.asset, this.image});
  
}