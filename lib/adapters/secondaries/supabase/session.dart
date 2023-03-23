import 'dart:async';

import 'package:peristock/adapters/secondaries/http/http.dart';
import 'package:peristock/adapters/secondaries/supabase/supabase.dart';
import 'package:peristock/application/logger/logger.dart';
import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/domain/ports/session.dart';
import 'package:peristock/domain/shared/exceptions.dart';
import 'package:peristock/domain/shared/types.dart';

class SessionRepository extends SupabaseRepository implements SessionRepositoryInterface {
  SessionRepository();

  @override
  Future<User> getCurrentUser() async {
    final response = await get('/auth/v1/user');

    if (response.statusCode != 200) {
      throw BadRequestException((response.body! as Json)['message'] as String);
    }

    return User.fromJson(response.body! as Json);
  }

  @override
  Future<AuthenticationStatus> handleDeeplink(String path) async {
    final uri = Uri.parse(path.replaceFirst('#', '?'));

    return onReceivedAuthDeeplink(uri);
  }

  @override
  Stream<AuthenticationStatus> onAuthenticationStatusEvents() {
    return authenticationStatus;
  }

  @override
  AuthenticationStatus recoverSession() {
    final credentials = getCredentials();

    return credentials == null ? AuthenticationStatus.unauthenticated : AuthenticationStatus.authenticated;
  }

  @override
  Future<void> signInWithOtp({required String email, required bool isWeb}) async {
    final response = await post(
      '/auth/v1/otp',
      queryParameters: {'redirect_to': isWeb ? 'http://localhost:3000' : 'supabase://peristock.io'},
      body: {'email': email},
    );

    if (response.statusCode != 200) {
      response.log();
      throw Exception(response);
    }
  }

  Future<AuthenticationStatus> onReceivedAuthDeeplink(Uri uri) async {
    final accessToken = uri.queryParameters['access_token'];
    final refreshToken = uri.queryParameters['refresh_token'];

    if (accessToken == null || refreshToken == null) {
      return AuthenticationStatus.unauthenticated;
    }

    try {
      final credentials = Credentials(accessToken: accessToken, refreshToken: refreshToken);
      await saveCredentials(credentials);

      return AuthenticationStatus.authenticated;
    } catch (error) {
      return AuthenticationStatus.unauthenticated;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await clearCredentials();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}

class SignupError<T> implements Exception {
  SignupError(this.response);

  final Response response;

  @override
  String toString() => 'Sign up failed with status code ${response.statusCode}';
}
