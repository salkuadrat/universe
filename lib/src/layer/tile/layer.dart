import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import '../../map/map.dart';
import '../../shared.dart';
import '../layer.dart';

class TileLayer extends GridLayer {
  
  /// Defines the structure to create the URLs for the tiles.
  /// `{s}` means one of the available subdomains (can be omitted)
  /// `{z}` zoom level
  /// `{x}` and `{y}` — tile coordinates
  /// `{r}` can be used to add "&commat;2x" to the URL to load retina tiles (can be omitted)
  ///
  /// Example:
  ///
  /// https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png
  ///
  /// Is translated to this:
  ///
  /// https://a.tile.openstreetmap.org/12/2177/1259.png
  final String templateUrl;
  final List<String> subdomains;
  final TileLayerOptions options;
  
  TileLayer(this.templateUrl, {Key key, dynamic subdomains='', this.options}) : 
    assert(subdomains is String || subdomains is List<String>),
    this.subdomains = parseSubdomains(subdomains),
    super(key: key, options: options);
  
  @override
  Widget buildLayer(BuildContext context, MapController controller, MapState state) {
    return TileContainer(
      templateUrl: templateUrl,
      subdomains: subdomains,
      options: options,
    );
  }
}

class TileContainer extends StatefulWidget {

  final String templateUrl;
  final List<String> subdomains;
  final TileLayerOptions options;

  const TileContainer({
    Key key, 
    this.templateUrl, 
    this.subdomains, 
    this.options,
  }) : super(key: key);

  @override
  _TileContainerState createState() => _TileContainerState();
}

class _TileContainerState extends State<TileContainer> {

  MapManager get manager => context.cubit<MapManager>();
  MapState get state => manager.state;
  MapController get controller => manager.state.controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(TileContainer oldTileContainer) {
    super.didUpdateWidget(oldTileContainer);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}