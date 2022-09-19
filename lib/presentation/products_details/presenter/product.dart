import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/presentation/di.dart';

typedef SearchProductByCode = FutureProviderFamily<Product, String>;

typedef SearchProductById = FutureProviderFamily<Product, int>;

abstract class ProductPresenter {
  static SearchProductByCode get searchProductByCode => _searchProductByCode;

  static SearchProductById get searchProductById => _searchProductById;
}

/// Call OpenFoodFact api to retrieve Product from barrecode.
final _searchProductByCode = FutureProvider.family<Product, String>(
  (ref, code) async {
    final repository = ref.read(Dependency.productRepository);

    return repository.searchProductByCode(code);
  },
  name: 'SearchProductByCode',
);

final _searchProductById = FutureProvider.family<Product, int>(
  (ref, id) async {
    final repository = ref.read(Dependency.productRepository);

    return repository.findItem(id: id);
  },
  name: 'SearchProductById',
);
