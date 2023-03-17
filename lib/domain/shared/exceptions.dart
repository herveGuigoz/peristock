class BadRequestException implements Exception {
  const BadRequestException([String? message]) : reason = message ?? 'Unknown error';

  final String reason;

  @override
  String toString() => 'BadRequestException: $reason';
}
