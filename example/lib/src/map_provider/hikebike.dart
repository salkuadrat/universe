import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class HikeBikeMap extends StatefulWidget {
  const HikeBikeMap({super.key});

  @override
  State<HikeBikeMap> createState() => _HikeBikeMapState();
}

class _HikeBikeMapState extends State<HikeBikeMap> {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [50, 11],
      zoom: 6,
      tiles: [U.HikeBikeTileLayer()],
    );
  }
}
