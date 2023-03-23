part of 'entities.dart';

enum Nutriscore { a, b, c, d, e }

@freezed
class Product with _$Product {
  const factory Product({
    required String name,
    String? barecode,
    Nutriscore? nutriscore,
    Nutriments? nutriments,
    String? image,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}

@freezed
class ProductSnapshot with _$ProductSnapshot {
  const factory ProductSnapshot({
    String? name,
    String? barecode,
    Nutriscore? nutriscore,
    Nutriments? nutriments,
    String? image,
  }) = _ProductSnapshot;

  factory ProductSnapshot.fromJson(Map<String, dynamic> json) => _$ProductSnapshotFromJson(json);
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

@freezed
class ProductFilters with _$ProductFilters {
  const factory ProductFilters({
    String? brand,
    String? store,
    Nutriscore? nutriscore,
  }) = _ProductFilters;

  factory ProductFilters.fromJson(Map<String, dynamic> json) => _$ProductFiltersFromJson(json);
}
