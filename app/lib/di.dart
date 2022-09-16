import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/products/adapters/supabase_repository.dart';
import 'package:peristock/products/domain/ports/products_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

final supabaseClient = Provider<supabase.SupabaseClient>(
  (ref) => supabase.Supabase.instance.client,
);

abstract class Dependency {
  static Provider<ProductRepositoryInterface> get productRepository {
    return _productRepository;
  }
}

final _productRepository = Provider<ProductRepositoryInterface>(
  (ref) => SupabaseProductRepository(ref.watch(supabaseClient)),
);
