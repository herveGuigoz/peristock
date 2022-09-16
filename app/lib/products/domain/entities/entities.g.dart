// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      id: json['id'] as int,
      name: json['name'] as String,
      bestBeforeDate: DateTime.parse(json['bestBeforeDate'] as String),
      quantity: json['quantity'] as int,
      quantityType: $enumDecode(_$QuantityTypeEnumMap, json['quantityType']),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bestBeforeDate': instance.bestBeforeDate.toIso8601String(),
      'quantity': instance.quantity,
      'quantityType': _$QuantityTypeEnumMap[instance.quantityType]!,
      'image': instance.image,
    };

const _$QuantityTypeEnumMap = {
  QuantityType.qt: 'qt',
  QuantityType.g: 'g',
  QuantityType.kg: 'kg',
  QuantityType.cl: 'cl',
  QuantityType.l: 'l',
};
