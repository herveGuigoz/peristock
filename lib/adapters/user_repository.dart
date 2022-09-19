import 'dart:async';

import 'package:peristock/domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class SupabaseUserRepository implements UserRepositoryInterface {
  SupabaseUserRepository(SupabaseClient supabaseClient, SupabaseAuth auth)
      : _supabaseClient = supabaseClient,
        _auth = auth;

  final SupabaseAuth _auth;

  final SupabaseClient _supabaseClient;

  @override
  Stream<User> get onUserChange async* {
    await for (final event in _auth.onAuthChange) {
      if (event == AuthChangeEvent.userUpdated) {
        yield await getUserProfile();
      }
    }
  }

  @override
  Future<User> getUserProfile() async {
    try {
      final response = await _supabaseClient
          .from('account')
          .select()
          .eq('id', _supabaseClient.auth.currentUser?.id)
          .single()
          .execute();

      return User.fromJson(response.data as Map<String, dynamic>);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UserInformationFailure(error), stackTrace);
    }
  }

  @override
  Future<void> updateUser({required UserSnapshot snapshot}) async {
    try {
      final user = User(
        id: _supabaseClient.auth.currentUser!.id,
        username: snapshot.username,
      );
      await _supabaseClient.from('account').upsert(user.toJson()).execute();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UpdateUserFailure(error), stackTrace);
    }
  }
}
