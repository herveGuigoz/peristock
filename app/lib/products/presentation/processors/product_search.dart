part of 'processors.dart';

/// Call OpenFoodFact api to retrieve Product from barrecode.
final searchProductByCode = FutureProviderFamily<Product, String>(
  (ref, code) async {
    final result = await SearchProductByCode(
      ref.read(Dependency.productRepository),
    ).execute(code);

    return result.data;
  },
);
