// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../map/map.dart';
import '../layer.dart';
import 'model/feature/collection.dart';
import 'model/feature/feature.dart';

class GeoJSONLayer extends InteractiveLayer {
  final String geojson;
  final GeoJSONLayerOptions? options;

  const GeoJSONLayer(
    this.geojson, {
    Key? key,
    this.options,
  }) : super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapState map) {
    Map<String, dynamic> json = (jsonDecode(geojson) as Map<String, dynamic>);

    if (json.containsKey('type')) {
      String? type = json['type'];

      if (type == 'FeatureCollection') {
        return FeatureCollection.from(json).layer(options);
      } else if (type == 'Feature') {
        return Feature.from(json).layer(options);
      }
    }

    return Container();
  }
}
