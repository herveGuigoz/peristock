part of 'entities.dart';

enum QuantityType { qt, g, kg, cl, l }

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String name,
    required DateTime bestBeforeDate,
    required int quantity,
    required QuantityType quantityType,
    String? image,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
class ProductSnapshot with _$ProductSnapshot {
  const factory ProductSnapshot({
    int? id,
    String? name,
    DateTime? bestBeforeDate,
    @Default(1) quantity,
    @Default(QuantityType.qt) QuantityType quantityType,
    String? image,
    String? asset,
  }) = _ProductSnapshot;

  factory ProductSnapshot.fromDomain(Product product) {
    return ProductSnapshot(
      id: product.id,
      name: product.name,
      quantity: product.quantity,
      quantityType: product.quantityType,
      image: product.image,
    );
  }
}
