import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/presentation/di.dart';

const _itemsPerPage = 30;

typedef ProductsProvider = FutureProviderFamily<Collection<Product>, int>;

typedef ProductCountProvider = Provider<AsyncValue<int>>;

typedef ProductProvider = AutoDisposeProviderFamily<AsyncValue<Product>, int>;

typedef DeleteProduct = AutoDisposeFutureProviderFamily<Result<void>, int>;

abstract class ProductsListPresenter {
  static ProductCountProvider get productsCount => _productsCountProvider;

  static ProductProvider get indexedProduct => _indexedProductProvider;

  static DeleteProduct get deleteProduct => _deleteProduct;

  static void refreshList(WidgetRef ref) => ref.invalidate(_productsProvider.firstPage);
}

/// Provide [Collection] of [Product] for given page.
final _productsProvider = ProductsProvider(
  (ref, page) async {
    assert(page >= 1, '"page" could not be negative');

    final repository = ref.read(Dependency.productRepository);

    return repository.findCollection(page: page, itemsPerPage: _itemsPerPage);
  },
  name: 'ProductsProvider',
);

/// Find [Product] in [_productsProvider] at the index provided in parameter.
final _indexedProductProvider = ProductProvider(
  (ref, index) {
    final page = index ~/ _itemsPerPage + 1;
    final currentIndex = index % _itemsPerPage;
    final products = ref.watch(_productsProvider(page));

    return products.whenData(
      (collection) => collection.items[currentIndex],
    );
  },
  name: 'ProductProvider',
);

/// Find total products items.
final _productsCountProvider = ProductCountProvider(
  (ref) {
    final collection = ref.watch(_productsProvider.firstPage);

    return collection.when(
      data: (value) => AsyncData(value.totalItems),
      error: AsyncError.new,
      loading: AsyncLoading.new,
    );
  },
  name: 'ProductCountProvider',
);

final _deleteProduct = DeleteProduct(
  (ref, id) async {
    final repository = ref.read(Dependency.productRepository);

    final result = await Result.guard(
      () async => repository.deleteProduct(id: id),
    );

    result.onSuccess(
      (_) => ref.invalidate(_productsProvider.firstPage),
    );

    return result;
  },
  name: 'DeleteProduct',
);

extension ProductsProviderExtension on ProductsProvider {
  FutureProvider<Collection<Product>> get firstPage => call(1);
}
