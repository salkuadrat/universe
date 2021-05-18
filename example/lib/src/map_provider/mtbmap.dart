import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class MtbMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.FreeMapSK(
      center: [51.555158, -0.108343],
      zoom: 13,
    );
  }
}
