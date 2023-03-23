part of 'http.dart';

@immutable
class RequestContext {
  const RequestContext({
    required this.method,
    required this.path,
    required this.authorizationRequired,
    this.headers,
    this.queryParameters,
    this.body,
  });

  final bool authorizationRequired;

  final Map<String, Object?>? body;

  final Map<String, String>? headers;

  final String method;

  final String path;

  final Map<String, Object>? queryParameters;

  /// Returns the full URL of the request.
  Uri get url {
    final uri = Uri.parse(path).replace(queryParameters: queryParameters);
    assert(uri.hasScheme, 'The path must contain a scheme');

    return uri;
  }

  /// Adds a header with [name] and [value] to [headers].
  RequestContext addHeader(String name, String value) {
    final headers = Map<String, String>.from(this.headers ?? {});
    headers[name] = value;

    return copyWith(headers: headers);
  }

  /// Removed the header with case-insensitive name [name].
  RequestContext removeHeader(String name) {
    final headers = Map<String, String>.from(this.headers ?? {})..removeWhere((header, value) => header == name);

    return copyWith(headers: headers);
  }

  RequestContext copyWith({
    String? method,
    String? path,
    bool? authorizationRequired,
    Map<String, String>? headers,
    Map<String, Object>? queryParameters,
    Map<String, Object?>? body,
  }) {
    return RequestContext(
      method: method ?? this.method,
      path: path ?? this.path,
      authorizationRequired: authorizationRequired ?? this.authorizationRequired,
      headers: headers ?? this.headers,
      queryParameters: queryParameters ?? this.queryParameters,
      body: body ?? this.body,
    );
  }

  @override
  bool operator ==(covariant RequestContext other) {
    if (identical(this, other)) return true;

    return other.method == method &&
        other.path == path &&
        other.authorizationRequired == authorizationRequired &&
        mapEquals(other.headers, headers) &&
        mapEquals(other.queryParameters, queryParameters) &&
        mapEquals(other.body, body);
  }

  // ignore: member-ordering
  @override
  int get hashCode {
    return method.hashCode ^
        path.hashCode ^
        authorizationRequired.hashCode ^
        headers.hashCode ^
        queryParameters.hashCode ^
        body.hashCode;
  }

  @override
  String toString() {
    return 'RequestContext(method: $method, path: $path, headers: $headers, queryParameters: $queryParameters, body: $body)';
  }
}
