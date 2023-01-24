import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'credentials.dart';
part 'jwt.dart';
part 'storage.dart';

abstract class HttpClientInterface {
  HttpClientInterface({
    Map<String, dynamic>? headers,
  }) : client = Dio()..options = BaseOptions(validateStatus: (_) => true, headers: headers);

  @protected
  final Dio client;

  @protected
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, Object>? headers,
    bool cacheResponse = false,
  }) async {
    try {
      final response = await client.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers, extra: {'cache_response': cacheResponse}),
      );

      return Response(response.data as T, response.statusCode!);
    } on DioError catch (_) {
      log(_.toString());
      throw NoInternetConnection(path: path);
    }
  }

  @protected
  Future<Response<T>> post<T>(
    String path, {
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
    String? contentType,
    Map<String, Object>? headers,
  }) async {
    try {
      final response = await client.post<T>(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(contentType: contentType, headers: headers),
      );

      return Response(response.data as T, response.statusCode!);
    } on DioError catch (_) {
      throw NoInternetConnection(path: path);
    }
  }

  @protected
  Future<Response<T>> put<T>(
    String path, {
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
    String? contentType,
    Map<String, Object>? headers,
  }) async {
    try {
      final response = await client.put<T>(
        path,
        data: jsonEncode(body),
        queryParameters: queryParameters,
        options: Options(contentType: contentType, headers: headers),
      );

      return Response(response.data as T, response.statusCode!);
    } on DioError catch (_) {
      throw NoInternetConnection(path: path);
    }
  }

  @protected
  Future<Response<T>> patch<T>(
    String path, {
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
    String? contentType,
    Map<String, Object>? headers,
  }) async {
    try {
      final response = await client.patch<T>(
        path,
        data: jsonEncode(body),
        queryParameters: queryParameters,
        options: Options(contentType: contentType, headers: headers),
      );

      return Response(response.data as T, response.statusCode!);
    } on DioError catch (_) {
      throw NoInternetConnection(path: path);
    }
  }

  @protected
  Future<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    String? contentType,
    Map<String, Object>? headers,
  }) async {
    try {
      final response = await client.delete<T>(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(contentType: contentType, headers: headers),
      );
      return Response(response.data as T, response.statusCode!);
    } on DioError catch (_) {
      throw NoInternetConnection(path: path);
    }
  }

  @protected
  Future<Response<T>> upload<T>(
    String path, {
    required String filePath,
  }) async {
    final response = await client.post<String>(
      path,
      data: FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      }),
      options: Options(
        headers: {'Content-Type': 'multipart/form-data'},
      ),
    );

    return Response(jsonDecode(response.data!) as T, response.statusCode!);
  }
}

@immutable
class Response<T> {
  const Response(this.body, this.statusCode);

  final T body;
  final int statusCode;

  @override
  String toString() => 'Response(json: $body, statusCode: $statusCode)';

  @override
  bool operator ==(covariant Response<T> other) {
    if (identical(this, other)) return true;

    return other.body == body && other.statusCode == statusCode;
  }

  @override
  int get hashCode => body.hashCode ^ statusCode.hashCode;
}

class NoInternetConnection implements Exception {
  NoInternetConnection({this.path});

  final String? path;

  @override
  String toString() => 'NoInternetConnection(path: $path)';
}
