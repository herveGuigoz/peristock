part of 'entities.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? avatar,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class UserSnapshot with _$UserSnapshot {
  const factory UserSnapshot({
    required String email,
  }) = _UserSnapshot;

  factory UserSnapshot.fromJson(Map<String, dynamic> json) => _$UserSnapshotFromJson(json);
}
