part of 'entities.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String name,
    @Default(1) int quantity,
    @Default(false) bool isComplete,
    double? price,
    DateTime? bestBeforeDate,
    String? image,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}

@freezed
class ProductSnapshot with _$ProductSnapshot {
  const factory ProductSnapshot({
    int? id,
    String? name,
    DateTime? bestBeforeDate,
    @Default(1) quantity,
    @Default(0.0) double price,
    String? image,
  }) = _ProductSnapshot;

  factory ProductSnapshot.fromDomain(Product product) {
    return ProductSnapshot(
      id: product.id,
      name: product.name,
      bestBeforeDate: product.bestBeforeDate,
      quantity: product.quantity,
      image: product.image,
    );
  }
}
