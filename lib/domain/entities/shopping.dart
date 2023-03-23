part of 'entities.dart';

@freezed
class ShoppingList with _$ShoppingList {
  const factory ShoppingList({
    required int id,
    required String name,
    required List<ListItem> listItems,
    required DateTime createdAt,
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
    required int listId,
    required Product product,
    required int quantity,
    required bool completed,
    double? price,
  }) = _ListItem;

  factory ListItem.fromJson(Map<String, dynamic> json) => _$ListItemFromJson(json);
}

@freezed
class ListItemSnapshot with _$ListItemSnapshot {
  const factory ListItemSnapshot({
    required int listId,
    int? id,
    Product? product,
    int? quantity,
    bool? completed,
    double? price,
  }) = _ListItemSnapshot;

  factory ListItemSnapshot.fromEntity(ListItem entity) {
    return ListItemSnapshot(
      listId: entity.listId,
      id: entity.id,
      product: entity.product,
      quantity: entity.quantity,
      completed: entity.completed,
      price: entity.price,
    );
  }

  factory ListItemSnapshot.fromJson(Map<String, dynamic> json) => _$ListItemSnapshotFromJson(json);
}
