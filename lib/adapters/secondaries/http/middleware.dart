part of 'http.dart';

typedef Middleware = Handler Function(Handler innerHandler);

typedef Handler = FutureOr<RequestContext> Function(RequestContext request);

Middleware _createMiddleware(Handler handler) {
  return (Handler innerHandler) {
    return (request) {
      return Future.sync(() => innerHandler(request)).then((result) async => handler(result));
    };
  };
}

extension on Middleware {
  /// Merges `this` and [handler] into a new [Handler].
  Handler addHandler(Handler handler) => this(handler);

  /// Gets a [Handler] from `this` [Middleware].
  Handler get handle => addHandler((context) => context);
}
