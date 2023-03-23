part of 'http.dart';

class Response {
  const Response._({required this.statusCode, required this.body});

  factory Response._fromHttpResponse(http.Response response) {
    final body = response.body.isEmpty ? null : jsonDecode(response.body);

    return Response._(statusCode: response.statusCode, body: body);
  }

  final Object? body;

  final int statusCode;

  @override
  String toString() => 'Response(statusCode: $statusCode, body: $body)';
}
