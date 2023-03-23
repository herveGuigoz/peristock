import 'dart:async';

import 'package:peristock/domain/entities/entities.dart';

abstract class ShoppingRepositoryInterface {
  Future<List<ShoppingList>> getListsCollection();

  FutureOr<ShoppingList> getListById(int id);

  FutureOr<ShoppingList> createList(ShoppingListSnapshot snapshot);

  FutureOr<ShoppingList> updateList(ShoppingListSnapshot snapshot);

  FutureOr<void> deleteList(ShoppingList item);

  FutureOr<ListItem> getListItemById(int id);

  FutureOr<void> createListItem(ListItemSnapshot snapshot);

  FutureOr<void> updateListItem(ListItemSnapshot snapshot);

  FutureOr<void> deleteListItem(ListItem item);
}
