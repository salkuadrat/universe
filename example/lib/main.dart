import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Universe Map Demo',
      theme: ThemeData(
        primarySwatch: Colours.deepSkyBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: U.GoogleMap(
          center: [-6.170039, 106.8241], 
          zoom: 15,
          //live: true,
          locator: true,
          markers: U.Markers(
            [
              [-6.181883, 106.826933], 
              [-6.170039, 106.8241],
            ],
            marker: MarkerIcon(
              icon: Icons.location_on,
              color: Colours.lightBlue,
            ),
          ),
          layers: [
            U.Circle(
              [-6.170039, 106.8241],
              radiusInMeter: 180, 
              stroke: true,
              strokeWidth: 0.75,
              strokeColor: Colors.grey[400],
              fill: true,
              fillColor: Colors.red,
            ),
            U.Polyline(
              [
                [-6.170039, 106.8241],
                [-6.175373, 106.827195],
                [-6.169976, 106.830979],
                [-6.178566, 106.832906],
                [-6.181883, 106.826933],
              ],
              strokeColor: Colors.blueGrey,
              isDotted: true,
            ),
            U.Polygon(
              [
                [-6.180630, 106.82655],
                [-6.182385, 106.82659],
                [-6.182377, 106.827295],
                [-6.180630, 106.827198],
              ],
              fillColor: Colors.lightBlue,
              fillOpacity: 0.5,
            ),
            U.Rectangle(
              [
                [-6.175096, 106.826793], // top left corner
                [-6.175804, 106.827518], // bottom right corner
              ],
              stroke: true,
              strokeColor: Colors.tealAccent,
              fillColor: Colors.teal,
              fillOpacity: 0.75,
            ),
          ],
          onTap: print,
        ),
      ),
    );
  }
}