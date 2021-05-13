import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

import 'shared.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return U.MapBox(
      accessToken: yourAccessTokenHere,
      center: [-6.175329, 106.827253], 
      zoom: 15,
      showLocator: true,
      /* locator: Locator(
        alignment: Alignment.bottomLeft,
        margin: EdgeInsets.only(left: 20, bottom: 24),
      ), */
      /* compass: Compass(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(right: 20, bottom: 32),
      ), */
      onReady: () => print('Map ready!'),
      markers: U.MarkerLayer(
        [
          Marker([-6.181975, 106.822323], data: 'Bank Indonesia'), 
          Marker([-6.176358, 106.821699], data: 'National Museum'),
        ],
        onTap: (latlng, data) => print('Welcome to $data'),
      ),
      circles: U.CircleLayer(
        [-6.170039, 106.8241],
        radius: 180, 
        stroke: false,
        strokeWidth: 0.75,
        strokeColor: Colors.red,
        fill: true,
      ),
      polylines: U.PolylineLayer(
        [
          [-6.170039, 106.8241],
          [-6.169976, 106.830979],
          [-6.178566, 106.832906],
          [-6.181883, 106.826933],
          [-6.181975, 106.822323],
        ],
        strokeColor: Colors.blueGrey,
        isDotted: true,
      ),
      polygons: U.PolygonLayer(
        [
          [-6.168962,106.830724],
          [-6.169906,106.830370],
          [-6.170418,106.830230],
          [-6.170514,106.830311],
          [-6.170605,106.830423],
          [-6.170754,106.830590],
          [-6.170893,106.830745],
          [-6.171048,106.830933],
          [-6.171256,106.831142],
          [-6.171330,106.831223],
          [-6.171912,106.831148],
          [-6.172056,106.831223],
          [-6.172024,106.831464],
          [-6.171485,106.832516],
          [-6.171208,106.832419],
          [-6.171117,106.832419],
          [-6.170936,106.832719],
          [-6.170701,106.832821],
          [-6.170664,106.832821],
          [-6.168744,106.831861],
          [-6.168546,106.831775],
          [-6.168482,106.831770],
          [-6.168397,106.831807],
          [-6.168232,106.831840],
          [-6.168141,106.831647],
          [-6.168141,106.831325],
          [-6.168173,106.830997],
          [-6.168248,106.830665],
          [-6.168946,106.830729],
        ],
        fillColor: Colors.orange,
        fillOpacity: 0.75,
      ),
      rectangles: U.RectangleLayer(
        [
          [-6.180684, 106.826658], // top left corner
          [-6.182377, 106.827295], // bottom right corner
        ],
        stroke: true,
        strokeColor: Colors.lightBlue,
      ),
      layers: [
        U.ImageOverlay(
          'http://img.freeflagicons.com/thumb/background_with_square_parts/indonesia/indonesia_640.png', 
          bounds: [
            [-6.180143, 106.823504],
            [-6.180344, 106.828948],
            [-6.17162, 106.82938],
            [-6.171958, 106.823674],
          ],
          fit: BoxFit.cover,
        ),
      ],
      onTap: print,
      onLongPress: print,
    );
  }
}