import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/adapters/products_repository.dart';
import 'package:peristock/adapters/session_repository.dart';
import 'package:peristock/adapters/user_repository.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/domain/ports/ports.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase, SupabaseAuth;

abstract class Dependency {
  static Provider<ProductRepositoryInterface> get productRepository => _productRepository;

  static Provider<UserRepositoryInterface> get authRepository => _authRepository;

  static Provider<SessionRepositoryInterface> get sessionRepository => _sessionRepository;
}

final _productRepository = Provider<ProductRepositoryInterface>(
  (ref) => SupabaseProductRepository(Supabase.instance.client),
  name: 'ProductRepositoryProvider',
);

final _authRepository = Provider<UserRepositoryInterface>(
  (ref) => SupabaseUserRepository(Supabase.instance.client, SupabaseAuth.instance),
  name: 'UserRepositoryProvider',
);

final _sessionRepository = Provider<SessionRepositoryInterface>(
  (ref) => SupabaseSessionRepository(Supabase.instance.client.auth),
  name: 'SessionRepositoryProvider',
);
