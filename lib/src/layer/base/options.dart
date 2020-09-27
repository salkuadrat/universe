import '../../shared.dart';

class LayerOptions {
  final bool interactive;
  final String attribution;
  
  const LayerOptions({
    this.interactive=interactiveDef, 
    this.attribution=attributionDef,
  });
}