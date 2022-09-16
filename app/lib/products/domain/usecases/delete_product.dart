import 'dart:async';

import 'package:peristock/products/domain/products.dart';
import 'package:peristock/shared/domain/domain.dart';

class DeleteProduct extends Usecase<int, void> {
  const DeleteProduct(this.productRepository);

  final ProductRepositoryInterface productRepository;

  @override
  Future<Result<void>> execute(int command) {
    return Result.guard(
      () => productRepository.deleteProduct(id: command),
    );
  }
}
