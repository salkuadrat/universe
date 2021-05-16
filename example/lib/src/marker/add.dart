import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import '../shared.dart';

class AddMarkerMap extends StatefulWidget {
  @override
  _AddMarkerMapState createState() => _AddMarkerMapState();
}

class _AddMarkerMapState extends State<AddMarkerMap> {
  final _mapKey = UniqueKey();

  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      key: _mapKey,
      type: MapBoxType.Outdoors,
      accessToken: yourAccessTokenHere,
      center: [51.555158, -0.108343],
      zoom: 15,
      showLocator: true,
      markers: U.MarkerLayer(
        markers,
        // long press the marker to remove it
        onLongPress: (position, latlng) {
          if (latlng is LatLng && mounted)
            setState(() {
              markers.removeWhere((marker) => marker.latlng == latlng);
            });
        },
      ),
      // tap to add marker
      onTap: (latlng) {
        if (mounted)
          setState(() {
            Marker marker = U.Marker(latlng, data: latlng);
            markers.add(marker);
          });
      },
    );
  }
}
