import 'dart:io';

import 'package:flutter/painting.dart';

class AdaptiveImageProvider extends ImageProvider {
  AdaptiveImageProvider(String url) : _delegate = _resolve(url);
  final ImageProvider _delegate;

  static ImageProvider _resolve(String url) {
    final uri = Uri.parse(url);

    switch (uri.scheme) {
      case 'asset':
        final path = uri.toString().replaceFirst('asset://', '');
        return AssetImage(path);
      case 'http':
      case 'https':
        return NetworkImage(url);
      case 'file':
      default:
        final file = File.fromUri(uri);
        return FileImage(file);
    }
  }

  @override
  ImageStreamCompleter loadBuffer(Object key, DecoderBufferCallback decode) {
    return _delegate.loadBuffer(key, decode);
  }

  @override
  Future<Object> obtainKey(ImageConfiguration configuration) {
    return _delegate.obtainKey(configuration);
  }
}
