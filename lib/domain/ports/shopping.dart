import 'dart:async';

import 'package:peristock/domain/entities/entities.dart';

abstract class ShoppingRepositoryInterface {
  FutureOr<List<ShoppingList>> findAll();

  FutureOr<void> createList(ShoppingListSnapshot snapshot);

  FutureOr<ShoppingList> updateList(ShoppingListSnapshot snapshot);

  FutureOr<void> addItem(ListItemSnapshot snapshot);

  FutureOr<void> deleteList(ShoppingList list);
}
