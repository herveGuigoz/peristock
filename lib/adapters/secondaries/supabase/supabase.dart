// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:peristock/adapters/primaries/storage/storage.dart';
import 'package:peristock/adapters/secondaries/http/http.dart';
import 'package:peristock/presentation/shared/extensions/extensions.dart';

abstract class SupabaseRepository extends HttpClientInterface with JwtAuthenticationMixin {
  SupabaseRepository()
      : storage = CredentialsStorage(),
        super(
          baseURL: 'https://$PROJECT_ID.supabase.co',
          headers: {'apikey': API_KEY, 'Accept': 'application/json'},
        ) {
    addMiddleware(_addAuthorizationHeader);
  }

  static const PROJECT_ID = String.fromEnvironment('PROJECT_ID');

  static const API_KEY = String.fromEnvironment('SUPABASE_KEY');

  @override
  @visibleForTesting
  final CredentialsStorageInterface storage;

  /// Add jwt token to request header if user is authenticated and take care of
  /// the refresh feature if the token is expired.
  Future<RequestContext> _addAuthorizationHeader(RequestContext context) async {
    if (!context.authorizationRequired) {
      return context;
    }

    var credentials = getCredentials();

    if (credentials == null) {
      return context;
    }

    final exp = JwtDecoder.getExpirationDate(credentials.accessToken);
    if (exp.isBefore(DateTime.now() + 5.minutes)) {
      try {
        credentials = await _refreshToken(credentials);
        await saveCredentials(credentials);
      } on RefreshTokenException catch (_) {
        await clearCredentials();
        rethrow;
      }
    }

    return context.addHeader('Authorization', 'Bearer ${credentials.accessToken}');
  }

  /// Called when the token is expired and need to be refreshed.
  Future<Credentials> _refreshToken(Credentials credentials) async {
    try {
      final response = await post(
        '/auth/v1/token',
        queryParameters: {'grant_type': 'refresh_token'},
        headers: {'Content-Type': 'application/json'},
        body: {'refresh_token': credentials.refreshToken},
        authorizationRequired: false,
      );

      return Credentials.fromJson(response.body! as Map<String, dynamic>);
    } on NoInternetConnection {
      rethrow;
    } catch (e) {
      Error.throwWithStackTrace(RefreshTokenException(e.toString()), StackTrace.current);
    }
  }
}

class CredentialsStorage implements CredentialsStorageInterface {
  CredentialsStorage() : _storage = Storage.instance;

  static const String _kStorageKey = 'credentials';

  final Storage _storage;

  @override
  Future<void> delete() async {
    try {
      await _storage.delete(_kStorageKey);
    } catch (_) {
      Error.throwWithStackTrace(RefreshTokenException('Failed to delete credentials'), StackTrace.current);
    }
  }

  @override
  Credentials? read() {
    try {
      final json = _storage.read(_kStorageKey);

      if (json == null) {
        return null;
      }

      return Credentials.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      Error.throwWithStackTrace(RefreshTokenException('Failed to convert $json to Credentials'), StackTrace.current);
    }
  }

  @override
  Future<void> write(Credentials credentials) async {
    try {
      await _storage.write(_kStorageKey, jsonEncode(credentials.toJson()));
    } catch (_) {
      Error.throwWithStackTrace(RefreshTokenException('Failed to save $credentials'), StackTrace.current);
    }
  }
}

class RefreshTokenException implements Exception {
  RefreshTokenException(this.error);

  final String error;

  @override
  String toString() => 'RefreshTokenException: $error';
}
