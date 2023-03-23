part of 'http.dart';

/// Globals options for the requests.
class Options {
  const Options({this.baseUrl, this.headers});

  final String? baseUrl;

  final Map<String, String>? headers;
}
