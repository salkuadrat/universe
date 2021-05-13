import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../../map/map.dart';
import '../layer.dart';
import 'model/feature/collection.dart';
import 'model/feature/feature.dart';

class GeoJSONLayer extends InteractiveLayer {

  final String geojson;
  final GeoJSONLayerOptions? options;

  GeoJSONLayer(this.geojson, {
    Key? key, 
    this.options,
  }) : super(key: key, options: options);
  
  @override
  Widget buildLayer(BuildContext context, MapController? controller, MapState map) {

    Map<String, dynamic> json = (jsonDecode(geojson) as Map<String, dynamic>);

    if(json.containsKey('type')) {
      String? type = json['type'];
      
      if(type == 'FeatureCollection') {
        return FeatureCollection.from(json).layer(options);
      } else if(type == 'Feature') {
        return Feature.from(json).layer(options);
      }
    }

    return Container();
  }
}