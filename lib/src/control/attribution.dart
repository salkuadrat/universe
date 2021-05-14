import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import '../layer/layer.dart';
import '../map/map.dart';

class Attribution extends MapLayer {
  
  final String? attribution;

  Attribution(this.attribution);

  @override 
  Widget buildLayer(BuildContext context, MapStates map) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.only(topRight: Radius.circular(8.0)),
          ),
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          child: Text(
            HtmlUnescape().convert(attribution ?? ''), 
            style: TextStyle(fontSize: 11, color: Colors.black45),
          ),
        ),
      ),
    );
  }
}