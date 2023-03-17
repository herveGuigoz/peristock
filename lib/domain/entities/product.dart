part of 'entities.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    String? nutriscore,
    Nutriments? nutriments,
    String? image,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}

@freezed
class ProductSnapshot with _$ProductSnapshot {
  const factory ProductSnapshot({
    String? id,
    String? name,
    String? image,
  }) = _ProductSnapshot;

  factory ProductSnapshot.fromDomain(Product product) {
    return ProductSnapshot(
      id: product.id,
      name: product.name,
      image: product.image,
    );
  }
}

@freezed
class Nutriments with _$Nutriments {
  const factory Nutriments({
    double? fiber,
    double? fat,
    double? saturatedFat,
    double? salt,
    double? sugars,
  }) = _Nutriments;

  factory Nutriments.fromJson(Map<String, dynamic> json) => _$NutrimentsFromJson(json);
}
