// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: require_trailing_commas

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:peristock/domain/ports/session.dart';
import 'package:rxdart/rxdart.dart';

part 'context.dart';
part 'credentials.dart';
part 'jwt.dart';
part 'middleware.dart';
part 'options.dart';
part 'response.dart';
part 'http.freezed.dart';
part 'http.g.dart';

abstract class HttpClientInterface {
  HttpClientInterface({
    required String baseURL,
    Map<String, String>? headers,
  }) : options = Options(baseUrl: baseURL, headers: headers) {
    _middleware = _createMiddleware(
      (context) => context.copyWith(
        path: Uri.parse(baseURL).resolve(context.path).toString(),
        headers: (headers ?? {}).mergeWith(context.headers),
      ),
    );
  }

  @protected
  final Options options;

  @protected
  final _httpClient = http.Client();

  late Middleware _middleware;

  @protected
  void addMiddleware(Handler handler) {
    _middleware = _createMiddleware(_middleware.addHandler(handler));
  }

  @protected
  Future<Response> get(
    String path, {
    Map<String, Object>? queryParameters,
    Map<String, String>? headers,
    bool authorizationRequired = true,
  }) async {
    try {
      final context = await _middleware.handle(RequestContext(
        method: 'GET',
        path: path,
        authorizationRequired: authorizationRequired,
        headers: headers,
        queryParameters: queryParameters,
      ));

      final response = await _httpClient.get(context.url, headers: context.headers);

      return Response._fromHttpResponse(response);
    } on SocketException catch (_, stackTrace) {
      Error.throwWithStackTrace(NoInternetConnection(path: path), stackTrace);
    }
  }

  @protected
  Future<Response> post(
    String path, {
    required Map<String, dynamic> body,
    Map<String, Object>? queryParameters,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
    bool authorizationRequired = true,
  }) async {
    try {
      final context = await _middleware.handle(RequestContext(
        method: 'POST',
        path: path,
        authorizationRequired: authorizationRequired,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
      ));

      final response = await _httpClient.post(context.url, headers: context.headers, body: jsonEncode(context.body));

      return Response._fromHttpResponse(response);
    } on SocketException catch (_, stackTrace) {
      Error.throwWithStackTrace(NoInternetConnection(path: path), stackTrace);
    }
  }

  @protected
  Future<Response> put(
    String path, {
    required Map<String, dynamic> body,
    Map<String, Object>? queryParameters,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
    bool authorizationRequired = true,
  }) async {
    try {
      final context = await _middleware.handle(RequestContext(
        method: 'PUT',
        path: path,
        authorizationRequired: authorizationRequired,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
      ));

      final response = await _httpClient.put(context.url, headers: context.headers, body: jsonEncode(context.body));

      return Response._fromHttpResponse(response);
    } on SocketException catch (_, stackTrace) {
      Error.throwWithStackTrace(NoInternetConnection(path: path), stackTrace);
    }
  }

  @protected
  Future<Response> patch(
    String path, {
    required Map<String, dynamic> body,
    Map<String, Object>? queryParameters,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
    bool authorizationRequired = true,
  }) async {
    try {
      final context = await _middleware.handle(RequestContext(
        method: 'PATCH',
        path: path,
        authorizationRequired: authorizationRequired,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
      ));

      final response = await _httpClient.patch(context.url, headers: context.headers, body: jsonEncode(context.body));

      return Response._fromHttpResponse(response);
    } on SocketException catch (_) {
      Error.throwWithStackTrace(NoInternetConnection(path: path), StackTrace.current);
    }
  }

  @protected
  Future<Response> delete(
    String path, {
    Map<String, Object>? queryParameters,
    Map<String, String>? headers,
    bool authorizationRequired = true,
  }) async {
    try {
      final context = await _middleware.handle(RequestContext(
        method: 'DELETE',
        path: path,
        authorizationRequired: authorizationRequired,
        headers: headers,
        queryParameters: queryParameters,
      ));

      final response = await _httpClient.delete(context.url, headers: context.headers, body: jsonEncode(context.body));

      return Response._fromHttpResponse(response);
    } on SocketException catch (_) {
      Error.throwWithStackTrace(NoInternetConnection(path: path), StackTrace.current);
    }
  }
}

class NoInternetConnection implements Exception {
  NoInternetConnection({this.path});

  final String? path;

  @override
  String toString() => 'NoInternetConnection(path: $path)';
}

extension MapExtension<K, V> on Map<K, V> {
  /// Returns a [Map] with the values from `this` and the values from [other].
  /// For keys that are the same between `this` and [other], the value in
  /// [other] is used.
  /// If [other] is `null` or empty, `this` is returned unchanged.
  Map<K, V> mergeWith(Map<K, V>? other) {
    if (other == null || other.isEmpty) return this;

    final value = Map.of(this);
    for (final entry in other.entries) {
      final val = entry.value;
      if (val == null) {
        value.remove(entry.key);
      } else {
        value[entry.key] = val;
      }
    }

    return value;
  }
}
