// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'collection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Collection<T> {
  List<T> get items => throw _privateConstructorUsedError;
  int get totalItems => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CollectionCopyWith<T, Collection<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionCopyWith<T, $Res> {
  factory $CollectionCopyWith(
          Collection<T> value, $Res Function(Collection<T>) then) =
      _$CollectionCopyWithImpl<T, $Res>;
  $Res call({List<T> items, int totalItems});
}

/// @nodoc
class _$CollectionCopyWithImpl<T, $Res>
    implements $CollectionCopyWith<T, $Res> {
  _$CollectionCopyWithImpl(this._value, this._then);

  final Collection<T> _value;
  // ignore: unused_field
  final $Res Function(Collection<T>) _then;

  @override
  $Res call({
    Object? items = freezed,
    Object? totalItems = freezed,
  }) {
    return _then(_value.copyWith(
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      totalItems: totalItems == freezed
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_CollectionCopyWith<T, $Res>
    implements $CollectionCopyWith<T, $Res> {
  factory _$$_CollectionCopyWith(
          _$_Collection<T> value, $Res Function(_$_Collection<T>) then) =
      __$$_CollectionCopyWithImpl<T, $Res>;
  @override
  $Res call({List<T> items, int totalItems});
}

/// @nodoc
class __$$_CollectionCopyWithImpl<T, $Res>
    extends _$CollectionCopyWithImpl<T, $Res>
    implements _$$_CollectionCopyWith<T, $Res> {
  __$$_CollectionCopyWithImpl(
      _$_Collection<T> _value, $Res Function(_$_Collection<T>) _then)
      : super(_value, (v) => _then(v as _$_Collection<T>));

  @override
  _$_Collection<T> get _value => super._value as _$_Collection<T>;

  @override
  $Res call({
    Object? items = freezed,
    Object? totalItems = freezed,
  }) {
    return _then(_$_Collection<T>(
      items: items == freezed
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      totalItems: totalItems == freezed
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Collection<T> implements _Collection<T> {
  const _$_Collection({required final List<T> items, required this.totalItems})
      : _items = items;

  final List<T> _items;
  @override
  List<T> get items {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int totalItems;

  @override
  String toString() {
    return 'Collection<$T>(items: $items, totalItems: $totalItems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Collection<T> &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other.totalItems, totalItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(totalItems));

  @JsonKey(ignore: true)
  @override
  _$$_CollectionCopyWith<T, _$_Collection<T>> get copyWith =>
      __$$_CollectionCopyWithImpl<T, _$_Collection<T>>(this, _$identity);
}

abstract class _Collection<T> implements Collection<T> {
  const factory _Collection(
      {required final List<T> items,
      required final int totalItems}) = _$_Collection<T>;

  @override
  List<T> get items;
  @override
  int get totalItems;
  @override
  @JsonKey(ignore: true)
  _$$_CollectionCopyWith<T, _$_Collection<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
