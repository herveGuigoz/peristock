enum AuthenticationStatus { authenticated, unauthenticated }

abstract class SessionRepositoryInterface {
  /// Method to notify when authentication status changed.
  Stream<AuthenticationStatus> onAuthenticationStatusEvents();

  /// Method to do sign in.
  Future<void> signInWithOtp({required String email, required bool isWeb});

  /// Recover session from deep links.
  Future<AuthenticationStatus?> handleDeeplink(String path);

  /// Recover/refresh session if it's available.
  AuthenticationStatus recoverSession();

  /// Method to do sign out.
  Future<void> signOut();
}

abstract class SessionException implements Exception {
  @override
  String toString() => '$runtimeType';
}

class SignInException implements SessionException {}
