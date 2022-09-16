import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/di.dart';
import 'package:peristock/products/domain/entities/entities.dart';
import 'package:peristock/products/domain/usecases/find_collection.dart';
import 'package:peristock/shared/domain/domain.dart';

const itemsPerPage = 30;

typedef ProductsProvider = FutureProviderFamily<Collection<Product>, int>;
typedef ProductCountProvider = Provider<AsyncValue<int>>;
typedef ProductProvider = AutoDisposeProviderFamily<AsyncValue<Product>, int>;

/// Provide [Collection] of [Product] for given page.
final productsProvider = ProductsProvider((ref, page) async {
  final result = await FindProducts(
    ref.read(Dependency.productRepository),
  ).execute(page);

  return result.data;
});

/// Find [Product] in [productsProvider] at the index provided in parameter.
final indexedProductProvider = ProductProvider((ref, index) {
  final page = index ~/ itemsPerPage + 1;
  final currentIndex = index % itemsPerPage;
  final products = ref.watch(productsProvider(page));

  return products.whenData(
    (collection) => collection.items[currentIndex],
  );
});

/// Find total products items.
final productsCountProvider = ProductCountProvider((ref) {
  final collection = ref.watch(productsProvider.firstPage);

  return collection.when(
    data: (value) => AsyncData(value.totalItems),
    error: (error, stackTrace) => AsyncError(error, stackTrace: stackTrace),
    loading: AsyncLoading.new,
  );
});

extension ProductsProviderExtension on ProductsProvider {
  FutureProvider<Collection<Product>> get firstPage => call(1);
}
