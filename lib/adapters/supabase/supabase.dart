// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:peristock/adapters/http/http.dart';

const PROJECT_ID = String.fromEnvironment(
  'PROJECT_ID',
);

const API_KEY = String.fromEnvironment(
  'SUPABASE_KEY',
);

typedef Json = Map<String, dynamic>;

abstract class SupabaseRepository extends HttpClientInterface {
  SupabaseRepository() : super(headers: {'apikey': API_KEY, 'Content-Type': 'application/json'}) {
    interceptor = SupabaseJwtInterceptor(storage: CredentialsStorage.instance);
    client.interceptors.add(interceptor);
  }

  static Future<void> initialize() async {
    await CredentialsStorage.initialize();
  }

  @protected
  late final JwtInterceptor interceptor;
}

class SupabaseJwtInterceptor extends JwtInterceptor {
  SupabaseJwtInterceptor({required super.storage});

  @override
  Future<Credentials> refreshToken(Credentials credentials) async {
    final response = await httpClient.post<Json>(
      'https://$PROJECT_ID.supabase.co/auth/v1/token',
      queryParameters: {
        'grant_type': 'refresh_token',
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${credentials.accessToken}',
          'apikey': API_KEY,
        },
      ),
      data: {'refresh_token': credentials.refreshToken},
    );

    return Credentials.fromJson(response.data!);
  }
}
