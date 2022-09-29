// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
class SupabseAccount with _$SupabseAccount {
  const factory SupabseAccount({
    required String id,
    required DateTime updated_at,
    required String username,
    required String avatar_url,
  }) = _SupabseAccount;

  factory SupabseAccount.fromJson(Map<String, dynamic> json) => _$SupabseAccountFromJson(json);
}
