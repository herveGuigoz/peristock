import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/di.dart';
import 'package:peristock/domain/domain.dart';

final shoppingListProvider = AsyncNotifierProviderFamily<ShoppingListNotifier, ShoppingList, int>(
  ShoppingListNotifier.new,
);

class ShoppingListNotifier extends FamilyAsyncNotifier<ShoppingList, int> {
  @override
  Future<ShoppingList> build(int arg) async {
    return ref.read(Dependency.shoppingRepository).getListById(arg);
  }

  Future<void> delete(ListItem item) async {
    await ref.read(Dependency.shoppingRepository).deleteListItem(item);
    ref.invalidateSelf();
  }
}
