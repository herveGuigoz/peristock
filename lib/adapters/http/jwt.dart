part of 'http.dart';

abstract class JwtInterceptor extends QueuedInterceptor with RefreshTokenMixin {
  JwtInterceptor({
    // required this.refreshTokenURL,
    required CredentialsStorageInterface storage,
  })  : _storage = storage,
        httpClient = Dio(BaseOptions(headers: {'Content-Type': 'application/json'}));

  /// Local storage to save user's [Credentials].
  @override
  final CredentialsStorageInterface _storage;

  @override
  @protected
  final Dio httpClient;

  Future<Credentials> refreshToken(Credentials credentials);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    await _addAuthorizationHeader(options);
    handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403) {
      await clearCredentials();
    }

    handler.next(err);
  }

  /// Add jwt token to request header if user is authenticated and take care of
  /// the refresh feature if the token is expired.
  Future<void> _addAuthorizationHeader(RequestOptions options) async {
    var credentials = getCredentials();

    if (credentials == null) {
      return;
    }

    if (credentials.isExpired) {
      try {
        final response = await refreshToken(credentials);
        await saveCredentials(response);
      } catch (_) {
        await clearCredentials();
        credentials = null;
      }
    }

    if (credentials != null) {
      options.headers.addAll(
        {'Authorization': 'Bearer ${_credentials!.accessToken}'},
      );
    }
  }
}

mixin RefreshTokenMixin {
  /// Local storage to save user's [Credentials].
  CredentialsStorageInterface get _storage;

  /// The current [Credentials].
  Credentials? _credentials;

  @visibleForTesting
  Dio get httpClient;

  final _controller = BehaviorSubject<Credentials?>();

  Stream<Credentials?> get authenticationStatus {
    _controller.add(getCredentials());
    return _controller.stream;
  }

  Credentials? getCredentials() {
    return _credentials ??= _storage.read();
  }

  /// Save the provided [Credentials].
  Future<void> saveCredentials(Credentials value) async {
    _credentials = value;
    await _storage.write(value);
    _controller.add(value);
  }

  /// Clears [Credentials].
  Future<void> clearCredentials() async {
    _credentials = null;
    await _storage.delete();
    _controller.add(null);
  }
}
