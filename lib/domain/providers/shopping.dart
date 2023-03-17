import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/domain/ports/shopping.dart';
import 'package:peristock/presentation/di.dart';

final shoppingListsProvider = AsyncNotifierProvider<ShoppingListsNotifier, List<ShoppingList>>(
  ShoppingListsNotifier.new,
);

final shoppingListProvider = Provider.autoDispose.family<AsyncValue<ShoppingList>, int>((ref, id) {
  final asyncLists = ref.watch(shoppingListsProvider);

  return asyncLists.whenData(
    (lists) => lists.firstWhere((list) => list.id == id),
  );
});

class ShoppingListsNotifier extends AsyncNotifier<List<ShoppingList>> {
  @override
  FutureOr<List<ShoppingList>> build() => _repository.findAll();

  ShoppingRepositoryInterface get _repository => ref.read(Dependency.shoppingRepository);

  Future<void> createNewList(ShoppingListSnapshot snapshot) async {
    await _repository.createList(snapshot);

    ref.invalidate(shoppingListsProvider);
  }
}
