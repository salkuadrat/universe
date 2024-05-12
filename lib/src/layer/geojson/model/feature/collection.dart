// ignore_for_file: library_prefixes

import '../../../layer.dart' as L;
import '../../options.dart';
import '../geojson.dart';
import '../type.dart';
import 'feature.dart';

class FeatureCollection extends GeoJSONModel {
  List<Feature>? features = [];

  FeatureCollection({this.features});

  @override
  GeoJSONType get type => GeoJSONType.FeatureCollection;

  void add(Feature feature) {
    features!.add(feature);
  }

  FeatureCollection.from(Map<String, dynamic> json) {
    assert(json.containsKey('type') && json['type'] == 'FeatureCollection');
    assert(json.containsKey('features'));

    List features = (json['features'] as List);

    for (Map f in features as Iterable<Map<dynamic, dynamic>>) {
      add(Feature.from(f as Map<String, dynamic>));
    }
  }

  @override
  L.MapLayer layer(GeoJSONLayerOptions? options,
      [Map<String, dynamic>? properties]) {
    return L.GroupLayer(
      layers: features!.map((f) => f.layer(options)).toList(),
      options: options,
    );
  }
}
