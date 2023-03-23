// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:peristock/domain/entities/entities.dart';

part 'product.dto.freezed.dart';
part 'product.dto.g.dart';

@freezed
class ProductDto with _$ProductDto {
  const factory ProductDto({
    @JsonKey(name: 'product_name') required String name,
    @JsonKey(name: 'code') String? barecode,
    @JsonKey(name: 'image_front_small_url') String? image,
    @JsonKey(name: 'nutriscore_grade') Nutriscore? nutriscore,
    Nutriments? nutriments,
  }) = _ProductDto;

  factory ProductDto.fromJson(Map<String, dynamic> json) => _$ProductDtoFromJson(json);

  const ProductDto._();

  ProductSnapshot toDomain() {
    return ProductSnapshot(
      name: name,
      barecode: barecode,
      nutriscore: nutriscore,
      nutriments: nutriments,
      image: image,
    );
  }
}
