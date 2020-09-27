import 'package:flutter/widgets.dart';

import 'tile.dart';

class AnimatedTile extends StatefulWidget {

  final Tile tile;
  final ImageProvider placeholder;

  AnimatedTile({Key key, @required this.tile, this.placeholder}) 
    : super(key: key);
  
  @override
  _AnimatedTileState createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<AnimatedTile> {
  
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
  void didUpdateWidget(AnimatedTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.tile.removeAnimationListener(_refresh);
    widget.tile.addAnimationListener(_refresh);
  }

  void _refresh() {
    if(mounted) setState(() {});
  }

  bool get isShowError => 
    widget.tile.isLoadError && 
    widget.placeholder != null;

  Widget get _errorTile => Image(
    image: widget.placeholder,
    fit: BoxFit.fill,
  );

  Widget get _tile => RawImage(
    image: widget.tile.imageInfo.image,
    fit: BoxFit.fill,
  );

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.tile.opacity,
      child: widget.tile.hasImage 
        ? _tile 
        : (isShowError ? _errorTile : Container()),
    );
  }
}