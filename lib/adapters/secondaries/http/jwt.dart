part of 'http.dart';

abstract class CredentialsStorageInterface {
  Credentials? read();

  Future<void> write(Credentials credentials);

  Future<void> delete();
}

mixin JwtAuthenticationMixin on HttpClientInterface {
  /// Local storage to save user's [Credentials].
  CredentialsStorageInterface get storage;

  /// The current [AuthenticationStatus].
  final _controller = BehaviorSubject<AuthenticationStatus>();

  /// Observable for the current [AuthenticationStatus].
  Stream<AuthenticationStatus> get authenticationStatus => _controller.stream;

  /// Get the current [Credentials].
  Credentials? getCredentials() {
    final credentials = storage.read();

    return credentials;
  }

  /// Save the provided [Credentials].
  Future<void> saveCredentials(Credentials value) async {
    await storage.write(value);
    _controller.add(AuthenticationStatus.authenticated);
  }

  /// Clears [Credentials].
  Future<void> clearCredentials() async {
    await storage.delete();
    _controller.add(AuthenticationStatus.unauthenticated);
  }
}
