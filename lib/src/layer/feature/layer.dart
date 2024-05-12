// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../map/map.dart';
import '../layer.dart';

class FeatureLayer extends GroupLayer {
  final dynamic properties;
  final FeatureLayerOptions? options;

  const FeatureLayer(
    List<MapLayer> layers, {
    Key? key,
    this.properties,
    this.options,
  }) : super(key: key, layers: layers, options: options);

  @override
  Widget buildLayer(BuildContext context, MapState map) {
    return Container();
  }
}
