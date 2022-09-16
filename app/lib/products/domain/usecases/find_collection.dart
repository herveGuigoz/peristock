import 'dart:async';

import 'package:peristock/products/domain/products.dart';
import 'package:peristock/shared/domain/domain.dart';

class FindProducts extends Usecase<int, Collection<Product>> {
  const FindProducts(this.productRepository);

  final ProductRepositoryInterface productRepository;

  @override
  Future<Result<Collection<Product>>> execute(int command) async {
    if (command < 1) {
      return Result.failure(Exception('"page" could not be negative'));
    }

    return Result.guard(
      () async => productRepository.findCollection(page: command),
    );
  }
}
