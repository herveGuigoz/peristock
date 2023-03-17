import 'dart:async';

import 'package:rxdart/rxdart.dart';

typedef Emiter = void Function(String event);

class Debouncer {
  Debouncer({
    this.duration = const Duration(milliseconds: 500),
  });

  final Duration duration;

  final _controller = BehaviorSubject<String>();

  Stream<String> get stream {
    return _controller.stream.debounceTime(duration);
  }

  Emiter get add {
    return _controller.sink.add;
  }

  void dispose() {
    _controller.close();
  }
}
