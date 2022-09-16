import 'dart:async';

import 'package:peristock/products/domain/products.dart';
import 'package:peristock/shared/domain/domain.dart';

class FindProductItem extends Usecase<int, Product> {
  const FindProductItem(this.productRepository);

  final ProductRepositoryInterface productRepository;

  @override
  Future<Result<Product>> execute(int command) async {
    return Result.guard(
      () async => productRepository.findItem(id: command),
    );
  }
}
