part of 'entities.dart';

@freezed
class ShoppingList with _$ShoppingList {
  const factory ShoppingList({
    required int id,
    required String name,
    required DateTime createdAt,
    required List<ListItem> items,
  }) = _ShoppingList;

  factory ShoppingList.fromJson(Map<String, dynamic> json) => _$ShoppingListFromJson(json);
}

@freezed
class ShoppingListSnapshot with _$ShoppingListSnapshot {
  const factory ShoppingListSnapshot({
    int? id,
    String? name,
    String? image,
  }) = _ShoppingListSnapshot;

  factory ShoppingListSnapshot.fromJson(Map<String, dynamic> json) => _$ShoppingListSnapshotFromJson(json);
}

@freezed
class ListItem with _$ListItem {
  const factory ListItem({
    required int id,
    required String name,
    required bool completed,
    int? quantity,
    double? price,
  }) = _ListItem;

  factory ListItem.fromJson(Map<String, dynamic> json) => _$ListItemFromJson(json);
}

@freezed
class ListItemSnapshot with _$ListItemSnapshot {
  const factory ListItemSnapshot({
    required int listId,
    int? id,
    String? name,
    bool? completed,
    int? quantity,
    double? price,
  }) = _ListItemSnapshot;

  factory ListItemSnapshot.fromJson(Map<String, dynamic> json) => _$ListItemSnapshotFromJson(json);
}
