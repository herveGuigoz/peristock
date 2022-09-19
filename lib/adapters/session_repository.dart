import 'dart:async';

import 'package:peristock/domain/exceptions/authentication.dart';
import 'package:peristock/domain/ports/session_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSessionRepository implements SessionRepositoryInterface {
  SupabaseSessionRepository(GoTrueClient auth) : _auth = auth;

  final GoTrueClient _auth;

  @override
  Future<void> signIn({required String email, required bool isWeb}) async {
    try {
      await _auth.signIn(
        email: email,
        options: AuthOptions(
          redirectTo: isWeb ? 'http://localhost:3000' : 'supabase://peristock.io',
        ),
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SignInFailure(error), stackTrace);
    }
  }

  @override
  Future<AuthStatus> recoverSession() async {
    final hasAccessToken = await SupabaseAuth.instance.localStorage.hasAccessToken();
    if (!hasAccessToken) {
      return AuthStatus.unAuthenticated;
    }

    final json = await SupabaseAuth.instance.localStorage.accessToken();
    if (json == null) {
      return AuthStatus.unAuthenticated;
    }

    final response = await _auth.recoverSession(json);
    if (response.error != null) {
      await SupabaseAuth.instance.localStorage.removePersistedSession();
      return AuthStatus.unAuthenticated;
    } else {
      return AuthStatus.authenticated;
    }
  }

  @override
  Future<AuthStatus?> handleDeeplink(Uri uri) async {
    if (!SupabaseAuth.instance.isAuthCallbackDeeplink(uri)) return null;

    return onReceivedAuthDeeplink(uri);
  }

  Future<AuthStatus> onReceivedAuthDeeplink(Uri uri) async {
    final response = await _auth.getSessionFromUrl(uri);
    if (response.error == null) {
      return AuthStatus.authenticated;
    }
    return AuthStatus.unAuthenticated;
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SignOutFailure(error), stackTrace);
    }
  }
}
