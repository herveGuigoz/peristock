// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get bestBeforeDate => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  QuantityType get quantityType => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      DateTime bestBeforeDate,
      int quantity,
      QuantityType quantityType,
      String? image});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res> implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  final Product _value;
  // ignore: unused_field
  final $Res Function(Product) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? bestBeforeDate = freezed,
    Object? quantity = freezed,
    Object? quantityType = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      bestBeforeDate: bestBeforeDate == freezed
          ? _value.bestBeforeDate
          : bestBeforeDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      quantityType: quantityType == freezed
          ? _value.quantityType
          : quantityType // ignore: cast_nullable_to_non_nullable
              as QuantityType,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$_ProductCopyWith(
          _$_Product value, $Res Function(_$_Product) then) =
      __$$_ProductCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      DateTime bestBeforeDate,
      int quantity,
      QuantityType quantityType,
      String? image});
}

/// @nodoc
class __$$_ProductCopyWithImpl<$Res> extends _$ProductCopyWithImpl<$Res>
    implements _$$_ProductCopyWith<$Res> {
  __$$_ProductCopyWithImpl(_$_Product _value, $Res Function(_$_Product) _then)
      : super(_value, (v) => _then(v as _$_Product));

  @override
  _$_Product get _value => super._value as _$_Product;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? bestBeforeDate = freezed,
    Object? quantity = freezed,
    Object? quantityType = freezed,
    Object? image = freezed,
  }) {
    return _then(_$_Product(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      bestBeforeDate: bestBeforeDate == freezed
          ? _value.bestBeforeDate
          : bestBeforeDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      quantityType: quantityType == freezed
          ? _value.quantityType
          : quantityType // ignore: cast_nullable_to_non_nullable
              as QuantityType,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Product implements _Product {
  const _$_Product(
      {required this.id,
      required this.name,
      required this.bestBeforeDate,
      required this.quantity,
      required this.quantityType,
      this.image});

  factory _$_Product.fromJson(Map<String, dynamic> json) =>
      _$$_ProductFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final DateTime bestBeforeDate;
  @override
  final int quantity;
  @override
  final QuantityType quantityType;
  @override
  final String? image;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, bestBeforeDate: $bestBeforeDate, quantity: $quantity, quantityType: $quantityType, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Product &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.bestBeforeDate, bestBeforeDate) &&
            const DeepCollectionEquality().equals(other.quantity, quantity) &&
            const DeepCollectionEquality()
                .equals(other.quantityType, quantityType) &&
            const DeepCollectionEquality().equals(other.image, image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(bestBeforeDate),
      const DeepCollectionEquality().hash(quantity),
      const DeepCollectionEquality().hash(quantityType),
      const DeepCollectionEquality().hash(image));

  @JsonKey(ignore: true)
  @override
  _$$_ProductCopyWith<_$_Product> get copyWith =>
      __$$_ProductCopyWithImpl<_$_Product>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  const factory _Product(
      {required final int id,
      required final String name,
      required final DateTime bestBeforeDate,
      required final int quantity,
      required final QuantityType quantityType,
      final String? image}) = _$_Product;

  factory _Product.fromJson(Map<String, dynamic> json) = _$_Product.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  DateTime get bestBeforeDate;
  @override
  int get quantity;
  @override
  QuantityType get quantityType;
  @override
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$_ProductCopyWith<_$_Product> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProductSnapshot {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  DateTime? get bestBeforeDate => throw _privateConstructorUsedError;
  dynamic get quantity => throw _privateConstructorUsedError;
  QuantityType get quantityType => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get asset => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductSnapshotCopyWith<ProductSnapshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductSnapshotCopyWith<$Res> {
  factory $ProductSnapshotCopyWith(
          ProductSnapshot value, $Res Function(ProductSnapshot) then) =
      _$ProductSnapshotCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String? name,
      DateTime? bestBeforeDate,
      dynamic quantity,
      QuantityType quantityType,
      String? image,
      String? asset});
}

/// @nodoc
class _$ProductSnapshotCopyWithImpl<$Res>
    implements $ProductSnapshotCopyWith<$Res> {
  _$ProductSnapshotCopyWithImpl(this._value, this._then);

  final ProductSnapshot _value;
  // ignore: unused_field
  final $Res Function(ProductSnapshot) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? bestBeforeDate = freezed,
    Object? quantity = freezed,
    Object? quantityType = freezed,
    Object? image = freezed,
    Object? asset = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      bestBeforeDate: bestBeforeDate == freezed
          ? _value.bestBeforeDate
          : bestBeforeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as dynamic,
      quantityType: quantityType == freezed
          ? _value.quantityType
          : quantityType // ignore: cast_nullable_to_non_nullable
              as QuantityType,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      asset: asset == freezed
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ProductSnapshotCopyWith<$Res>
    implements $ProductSnapshotCopyWith<$Res> {
  factory _$$_ProductSnapshotCopyWith(
          _$_ProductSnapshot value, $Res Function(_$_ProductSnapshot) then) =
      __$$_ProductSnapshotCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String? name,
      DateTime? bestBeforeDate,
      dynamic quantity,
      QuantityType quantityType,
      String? image,
      String? asset});
}

/// @nodoc
class __$$_ProductSnapshotCopyWithImpl<$Res>
    extends _$ProductSnapshotCopyWithImpl<$Res>
    implements _$$_ProductSnapshotCopyWith<$Res> {
  __$$_ProductSnapshotCopyWithImpl(
      _$_ProductSnapshot _value, $Res Function(_$_ProductSnapshot) _then)
      : super(_value, (v) => _then(v as _$_ProductSnapshot));

  @override
  _$_ProductSnapshot get _value => super._value as _$_ProductSnapshot;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? bestBeforeDate = freezed,
    Object? quantity = freezed,
    Object? quantityType = freezed,
    Object? image = freezed,
    Object? asset = freezed,
  }) {
    return _then(_$_ProductSnapshot(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      bestBeforeDate: bestBeforeDate == freezed
          ? _value.bestBeforeDate
          : bestBeforeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      quantity: quantity == freezed ? _value.quantity : quantity,
      quantityType: quantityType == freezed
          ? _value.quantityType
          : quantityType // ignore: cast_nullable_to_non_nullable
              as QuantityType,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      asset: asset == freezed
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ProductSnapshot implements _ProductSnapshot {
  const _$_ProductSnapshot(
      {this.id,
      this.name,
      this.bestBeforeDate,
      this.quantity = 1,
      this.quantityType = QuantityType.qt,
      this.image,
      this.asset});

  @override
  final int? id;
  @override
  final String? name;
  @override
  final DateTime? bestBeforeDate;
  @override
  @JsonKey()
  final dynamic quantity;
  @override
  @JsonKey()
  final QuantityType quantityType;
  @override
  final String? image;
  @override
  final String? asset;

  @override
  String toString() {
    return 'ProductSnapshot(id: $id, name: $name, bestBeforeDate: $bestBeforeDate, quantity: $quantity, quantityType: $quantityType, image: $image, asset: $asset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductSnapshot &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.bestBeforeDate, bestBeforeDate) &&
            const DeepCollectionEquality().equals(other.quantity, quantity) &&
            const DeepCollectionEquality()
                .equals(other.quantityType, quantityType) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality().equals(other.asset, asset));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(bestBeforeDate),
      const DeepCollectionEquality().hash(quantity),
      const DeepCollectionEquality().hash(quantityType),
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(asset));

  @JsonKey(ignore: true)
  @override
  _$$_ProductSnapshotCopyWith<_$_ProductSnapshot> get copyWith =>
      __$$_ProductSnapshotCopyWithImpl<_$_ProductSnapshot>(this, _$identity);
}

abstract class _ProductSnapshot implements ProductSnapshot {
  const factory _ProductSnapshot(
      {final int? id,
      final String? name,
      final DateTime? bestBeforeDate,
      final dynamic quantity,
      final QuantityType quantityType,
      final String? image,
      final String? asset}) = _$_ProductSnapshot;

  @override
  int? get id;
  @override
  String? get name;
  @override
  DateTime? get bestBeforeDate;
  @override
  dynamic get quantity;
  @override
  QuantityType get quantityType;
  @override
  String? get image;
  @override
  String? get asset;
  @override
  @JsonKey(ignore: true)
  _$$_ProductSnapshotCopyWith<_$_ProductSnapshot> get copyWith =>
      throw _privateConstructorUsedError;
}
