import 'package:peristock/domain/entities/entities.dart';

class ProductDto {
  ProductDto({
    required this.code,
    required this.name,
    required this.image,
    required this.nutriscore,
    required this.ecoscoreGrade,
    required this.nutriments,
  });

  factory ProductDto.fromJson(Map<String, dynamic> map) {
    return ProductDto(
      code: map['code'] as String,
      name: map['product_name'] as String,
      image: map['image_front_small_url'] as String,
      nutriscore: map['nutriscore_grade'] as String,
      ecoscoreGrade: map['ecoscore_grade'] as String,
      nutriments: NutrimentsDto.fromJson(map['nutriments'] as Map<String, dynamic>),
    );
  }

  final String code;

  final String name;

  final String image;

  final String nutriscore;

  final String ecoscoreGrade;

  final NutrimentsDto nutriments;

  Product toDomain() {
    return Product(id: code, name: name, image: image, nutriscore: nutriscore, nutriments: nutriments.toDomain());
  }
}

class NutrimentsDto {
  NutrimentsDto({
    this.carbohydrates,
    this.energy,
    this.fat,
    this.fiber,
    this.novaGroup,
    this.proteins,
    this.salt,
    this.saturatedFat,
    this.sodium,
    this.sugars,
  });

  factory NutrimentsDto.fromJson(Map<String, dynamic> map) {
    return NutrimentsDto(
      carbohydrates: (map['carbohydrates'] as Object?).toDouble(),
      energy: (map['energy'] as Object?).toDouble(),
      fat: (map['fat'] as Object?).toDouble(),
      fiber: (map['fiber'] as Object?).toDouble(),
      novaGroup: (map['nova-group'] as Object?).toDouble(),
      proteins: (map['proteins'] as Object?).toDouble(),
      salt: (map['salt'] as Object?).toDouble(),
      saturatedFat: (map['saturated-fat'] as Object?).toDouble(),
      sodium: (map['sodium'] as Object?).toDouble(),
      sugars: (map['sugars'] as Object?).toDouble(),
    );
  }

  final double? carbohydrates;

  final double? energy;

  final double? fat;

  final double? fiber;

  final double? novaGroup;

  final double? proteins;

  final double? salt;

  final double? saturatedFat;

  final double? sodium;

  final double? sugars;

  Nutriments toDomain() {
    return Nutriments(fat: fat, fiber: fiber, salt: salt, saturatedFat: saturatedFat, sugars: sugars);
  }
}

extension on Object? {
  double? toDouble() {
    if (null == this) {
      return null;
    }

    return double.tryParse(this!.toString());
  }
}
