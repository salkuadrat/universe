import 'package:universe/src/layer/geojson/model/position.dart';

import '../type.dart';
import 'linestring.dart';

class LinearRing extends LineString {

  LinearRing(List<Position> positions) : 
    assert(positions.length >= 4),
    assert(positions.first.latlng == positions.last.latlng),
    super(positions);
  
  @override
  GeoJSONType get type => GeoJSONType.LinearRing;
  
}