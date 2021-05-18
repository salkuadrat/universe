import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class LiveMapWithoutAutoMoving extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.GoogleMap(
      type: GoogleMapType.Street,
      center: [-6.169976, 106.830979],
      zoom: 16,
      live: true,
      // moveWhenLive: false will make the map live (constantly search for user location),
      // set the location indicator to current user location, but does not
      // move the center of the maps automatically to that location.

      // moveWhenLive has default value set to true
      moveWhenLive: false,
    );
  }
}
