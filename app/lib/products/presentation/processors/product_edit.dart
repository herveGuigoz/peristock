part of 'processors.dart';

class EditProductProcessor extends ProductSnapshotProcessor {
  EditProductProcessor({required Product product})
      : super(product.toSnapshot());

  @override
  Future<Result<void>> submitForm(ProviderContainer container) async {
    if (state.name?.isEmpty ?? true) {
      return Result.failure(Exception('The name is required'));
    }

    final result = await CreateProduct(
      container.read(Dependency.productRepository),
    ).execute(state);

    result.onSuccess(
      (_) => container.invalidate(productsProvider.firstPage),
    );

    return result;
  }
}

extension on Product {
  ProductSnapshot toSnapshot() => ProductSnapshot.fromDomain(this);
}
