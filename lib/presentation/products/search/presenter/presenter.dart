import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/di.dart';
import 'package:peristock/domain/entities/entities.dart';

final searchProductsProvider = FutureProvider.family<List<ProductSnapshot>, String>((ref, query) {
  final filters = ref.watch(filtersProvider);
  
  return ref.read(Dependency.productRepository).searchProductsByName(query, filters: filters);
});

final filtersProvider = StateProvider<ProductFilters>((ref) => const ProductFilters());
