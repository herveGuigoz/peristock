part of 'processors.dart';

final deleteProduct = FutureProvider.autoDispose.family<Result<void>, int>(
  (ref, id) async {
    final result = await DeleteProduct(
      ref.read(Dependency.productRepository),
    ).execute(id);

    result.onSuccess(
      (_) => ref.invalidate(productsProvider.firstPage),
    );

    return result;
  },
);
