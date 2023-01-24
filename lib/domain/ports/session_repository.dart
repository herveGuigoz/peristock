import 'dart:async';

enum AuthStatus { authenticated, unauthenticated }

abstract class SessionRepositoryInterface {
  /// Method to do sign in
  FutureOr<void> signIn({required String email, required bool isWeb});

  /// Recover session from deep links.
  FutureOr<AuthStatus> handleDeeplink(String path);

  /// Recover/refresh session if it's available.
  FutureOr<AuthStatus> recoverSession();

  /// Method to do sign out.
  FutureOr<void> signOut();
}
