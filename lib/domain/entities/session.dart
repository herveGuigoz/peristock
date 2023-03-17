part of 'entities.dart';

@freezed
class Session with _$Session {
  const factory Session.unauthenticated() = Unauthenticated;

  const factory Session.authenticated({
    required User user,
  }) = Authenticated;

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
}
