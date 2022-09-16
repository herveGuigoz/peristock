import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection.freezed.dart';

@freezed
class Collection<T> with _$Collection<T> {
  const factory Collection({
    required List<T> items,
    required int totalItems,
  }) = _Collection<T>;

  factory Collection.empty() {
    return const Collection(items: [], totalItems: 0);
  }
}
