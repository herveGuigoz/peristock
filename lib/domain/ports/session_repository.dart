enum AuthStatus { authenticated, unAuthenticated }

abstract class SessionRepositoryInterface {
  /// Method to do sign in
  Future<void> signIn({required String email, required bool isWeb});

  /// Recover session from deep links.
  Future<AuthStatus?> handleDeeplink(Uri uri);

  /// Recover/refresh session if it's available.
  Future<AuthStatus> recoverSession();

  /// Method to do sign out.
  Future<void> signOut();
}
