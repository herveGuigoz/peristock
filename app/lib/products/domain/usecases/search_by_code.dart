// ignore_for_file: subtype_of_sealed_class

import 'dart:async';

import 'package:peristock/products/domain/entities/entities.dart';
import 'package:peristock/products/domain/ports/products_repository.dart';
import 'package:peristock/shared/domain/domain.dart';

class SearchProductByCode extends Usecase<String, Product> {
  const SearchProductByCode(this.productRepository);

  final ProductRepositoryInterface productRepository;

  @override
  Future<Result<Product>> execute(String command) async {
    if (command.isEmpty) {
      return Result.failure(EmptyCodeException());
    }

    return Result.guard(
      () async => productRepository.searchProductByCode(command),
    );
  }
}

class EmptyCodeException implements Exception {
  @override
  String toString() => 'EAN Code is missing';
}
