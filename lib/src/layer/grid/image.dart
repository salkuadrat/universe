import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'tile.dart';

class TileImage extends StatefulWidget {

  final Tile tile;
  final ImageProvider errorImage;

  TileImage({Key key, @required this.tile, this.errorImage}) 
    : super(key: key);
  
  @override
  _TileImageState createState() => _TileImageState();
}

class _TileImageState extends State<TileImage> {
  
  @override
  void initState() {
    super.initState();
    widget.tile.addAnimationListener(_refresh);
  }

  @override
  void dispose() {
    widget.tile.removeAnimationListener(_refresh);
    super.dispose();
  }

  @override
  void didUpdateWidget(TileImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget?.tile?.removeAnimationListener(_refresh);
    widget.tile.removeAnimationListener(_refresh);
    widget.tile.addAnimationListener(_refresh);
  }

  void _refresh() {
    if(mounted) setState(() {});
  }

  bool get isShowError => 
    widget.tile.isLoadError && 
    widget.errorImage != null;

  Widget get _errorTile => Image(
    image: widget.errorImage,
    fit: BoxFit.fill,
    filterQuality: FilterQuality.medium,
  );

  Widget get _tile => Image(
    image: widget.tile.imageProvider,
    fit: BoxFit.fill,
    filterQuality: FilterQuality.high,
  );

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.tile.opacity,
      child: widget.tile.hasImage 
        ? _tile 
        : (isShowError 
          ? _errorTile 
          : Container()),
    );
  }
}