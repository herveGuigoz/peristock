part of 'http.dart';

@freezed
class Credentials with _$Credentials {
  const factory Credentials({
    required String accessToken,
    required String refreshToken,
  }) = _Credentials;

  factory Credentials.fromJson(Map<String, dynamic> json) => _$CredentialsFromJson(json);

  const Credentials._();

  bool get isExpired => JwtDecoder.isExpired(accessToken);
}
