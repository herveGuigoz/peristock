import 'dart:async';

import 'package:peristock/adapters/http/http.dart';
import 'package:peristock/adapters/supabase/supabase.dart';
import 'package:peristock/domain/exceptions/authentication.dart';
import 'package:peristock/domain/ports/session_repository.dart';

class SessionRepository extends SupabaseRepository implements SessionRepositoryInterface {
  SessionRepository();

  @override
  Future<void> signIn({required String email, required bool isWeb}) async {
    final response = await post<void>(
      'https://$PROJECT_ID.supabase.co/auth/v1/otp',
      queryParameters: {'redirect_to': isWeb ? 'http://localhost:3000' : 'supabase://peristock.io'},
      body: {
        'email': email,
        'create_user': true,
      },
    );
    
    

    if (response.statusCode != 200) {
      throw SignInFailure(response);
    }
  }

  @override
  Future<AuthStatus> handleDeeplink(String path) async {
    final uri = Uri.parse(path.replaceFirst('#', '?'));
    if (!uri.queryParameters.containsKey('access_token')) {
      return AuthStatus.unauthenticated;
    }

    return onReceivedAuthDeeplink(uri);
  }

  Future<AuthStatus> onReceivedAuthDeeplink(Uri uri) async {
    final accessToken = uri.queryParameters['access_token'];
    final refreshToken = uri.queryParameters['refresh_token'];

    if (accessToken == null || refreshToken == null) {
      return AuthStatus.unauthenticated;
    }

    try {
      final credentials = Credentials(accessToken: accessToken, refreshToken: refreshToken);
      await interceptor.saveCredentials(credentials);
      return AuthStatus.authenticated;
    } catch (error) {
      return AuthStatus.unauthenticated;
    }
  }

  @override
  AuthStatus recoverSession() {
    final credentials = interceptor.getCredentials();
    return credentials == null ? AuthStatus.unauthenticated : AuthStatus.authenticated;
  }

  @override
  Future<void> signOut() async {
    try {
      await interceptor.clearCredentials();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
