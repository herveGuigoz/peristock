import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/di.dart';
import 'package:peristock/products/domain/products.dart';
import 'package:peristock/products/domain/usecases/find_item.dart';
import 'package:peristock/shared/domain/domain.dart';

/// Call OpenFoodFact api to retrieve Product from barrecode.
final searchProductByCode = FutureProvider.family<Result<Product>, String>(
  (ref, code) async {
    final result = await SearchProductByCode(
      ref.read(Dependency.productRepository),
    ).execute(code);

    return result;
  },
);

final searchProductById = FutureProvider.family<Product, int>((ref, id) async {
  final result = await FindProductItem(
    ref.read(Dependency.productRepository),
  ).execute(id);

  return result.data;
});
