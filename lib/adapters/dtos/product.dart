// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:peristock/domain/domain.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class SupabseProduct with _$SupabseProduct {
  const factory SupabseProduct({
    required int id,
    required String name,
    required DateTime best_before_date,
    required int quantity,
    required String quantity_type,
    String? image_url,
  }) = _SupabseProduct;

  SupabseProduct._();

  factory SupabseProduct.fromJson(Map<String, dynamic> json) => _$SupabseProductFromJson(json);

  Product toDomain() {
    return Product.fromJson({
      'id': id,
      'name': name,
      'bestBeforeDate': best_before_date.toIso8601String(),
      'quantity': quantity,
      'quantityType': quantity_type,
      'image': image_url,
    });
  }
}
