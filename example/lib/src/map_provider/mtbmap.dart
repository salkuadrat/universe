import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class MtbMap extends StatelessWidget {
  const MtbMap({super.key});

  @override
  Widget build(BuildContext context) {
    return U.MtbMap(
      center: [51.555158, -0.108343],
      zoom: 13,
    );
  }
}
