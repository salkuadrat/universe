import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import '../layer/layer.dart';
import '../map/map.dart';

/// Map Attribution Layer
class Attribution extends MapLayer {
  /// Attribution to show on the map.
  final String? attribution;

  const Attribution(this.attribution, {super.key});

  @override
  Widget buildLayer(BuildContext context, MapState map) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 10,
          ),
          child: Text(
            HtmlUnescape().convert(attribution ?? ''),
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black45,
            ),
          ),
        ),
      ),
    );
  }
}
