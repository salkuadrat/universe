import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class WmsMap extends StatelessWidget {
  const WmsMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return U.Map(
      controller: MapController(),
      center: [-6.175520973390827, 106.82716012001038],
      zoom: 14,
      base: U.WMSTileLayer(
        'https://jimatt.com/wms?',
        format: 'image/png',
        layers: 'basemap',
        maxZoom: 21,
        transparent: false,
        crs: CRS.EPSG3857,
        additionalOptions: {'tiled': true, 'PANE': 'labels'},
      ),
    );
  }
}
