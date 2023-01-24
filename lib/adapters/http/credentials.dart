part of 'http.dart';

@immutable
class Credentials {
  const Credentials({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Credentials.fromJson(Map<String, dynamic> json) {
    return Credentials(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }

  final String accessToken;
  final String refreshToken;

  bool get isExpired => JwtDecoder.isExpired(accessToken);

  String toJson() {
    final json = {'access_token': accessToken, 'refresh_token': refreshToken};
    return jsonEncode(json);
  }

  @override
  bool operator ==(covariant Credentials other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken && other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode;
}
