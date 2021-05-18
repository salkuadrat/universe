/* import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class CacheImage extends ImageProvider<CacheImage> {
  CacheImage(
    String url, {
    this.scale = 1.0,
    this.cache = true,
    this.duration = const Duration(milliseconds: 750),
    this.durationMultiplier = 1.5,
    this.durationExpiration = const Duration(seconds: 10),
  }) : _resource =
            Resource(url, duration, durationMultiplier, durationExpiration);

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// Enable or disable image caching.
  final bool cache;

  /// Retry duration if download fails.
  final Duration duration;

  /// Retry duration multiplier.
  final double durationMultiplier;

  /// Retry duration expiration.
  final Duration durationExpiration;

  Resource _resource;

  Future<Codec> _fetchImage() async {
    Uint8List? file;

    await _resource.init();
    final bool check = await _resource.checkFile();

    if (check) {
      file = await _resource.getFile();
    } else {
      file = await _resource.storeFile();
    }

    if (file == null) {
      throw StateError('$file is empty and cannot be loaded as an image.');
    }

    return PaintingBinding.instance!.instantiateImageCodec(file);
  }

  @override
  Future<CacheImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<CacheImage>(this);
  }

  @override
  ImageStreamCompleter load(CacheImage key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: key._fetchImage(),
      scale: key.scale,
      informationCollector: () sync* {
        yield DiagnosticsProperty<ImageProvider>(
            'Image provider: $this \n Image key: $key', this,
            style: DiagnosticsTreeStyle.errorProperty);
      },
    );
  }
}

class Resource {
  final String uri;
  final Duration duration;
  final double durationMultiplier;
  final Duration durationExpiration;

  late Uri _temp;
  late Uri _local;
  late Uri _remote;
  late Duration _retry;

  Resource(
      this.uri, this.duration, this.durationMultiplier, this.durationExpiration)
      : _retry = duration;

  Uri get remote => _remote;
  Uri get temp => _temp;
  Uri get local => _local;

  Uri _parse(String uri) {
    return Uri.parse(uri);
  }

  Future<Uri> _getTempDir() async {
    final Directory temp = await getTemporaryDirectory();
    return _parse(temp.path);
  }

  Future<Resource> init() async {
    _temp = await _getTempDir();
    _remote = _parse(uri);
    _local = _parse(_temp.path + '/' + _remote.hashCode.toString());

    return this;
  }

  Future<bool> checkFile() async {
    final File file = File(_local.path);

    if (file.existsSync() && file.lengthSync() > 0) {
      return true;
    }

    return false;
  }

  Future<Uint8List?> getFile() async {
    final File file = File(_local.path);

    if (file.existsSync() && file.lengthSync() > 0) {
      return file.readAsBytesSync();
    }

    return null;
  }

  Future<Uint8List> storeFile() async {
    File file = await File(_local.path).create(recursive: true);

    while (file.lengthSync() <= 0) {
      await Future.delayed(_retry);

      try {
        HttpClient httpClient = new HttpClient();

        final HttpClientRequest request = await httpClient.getUrl(_remote);
        final HttpClientResponse response = await request.close();

        final Uint8List bytes = await consolidateHttpClientResponseBytes(
            response,
            autoUncompress: false);
        file = await file.writeAsBytes(bytes);
      } catch (err) {
        _retry += _retry * this.durationMultiplier;
      }

      // Check duration expiration
      if (_retry > durationExpiration) {
        break;
      }
    }

    return file.readAsBytesSync();
  }
}
 */
