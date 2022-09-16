import 'dart:async';

import 'package:peristock/products/domain/products.dart';
import 'package:peristock/shared/domain/domain.dart';

class CreateProduct extends Usecase<ProductSnapshot, void> {
  const CreateProduct(this.productRepository);

  final ProductRepositoryInterface productRepository;

  @override
  Future<Result<void>> execute(ProductSnapshot command) async {
    var snapshot = command;

    final daysLeft = snapshot.bestBeforeDate?.difference(DateTime.now()).inDays;
    if ((daysLeft ?? 0) < 1) {
      return Failure(InvalidDLCException());
    }

    final thumbnail = snapshot.asset;
    if (thumbnail != null) {
      final image = await productRepository.uploadImage(filePath: thumbnail);
      snapshot = snapshot.copyWith(image: image);
    }

    return Result.guard(
      () => productRepository.saveProduct(value: snapshot),
    );
  }
}
