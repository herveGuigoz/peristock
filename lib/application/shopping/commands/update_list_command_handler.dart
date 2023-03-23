import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/di.dart';
import 'package:peristock/application/shared/command.dart';
import 'package:peristock/application/shared/result.dart';
import 'package:peristock/application/shopping/commands/update_list_command.dart';
import 'package:peristock/application/shopping/providers.dart';
import 'package:peristock/domain/entities/entities.dart';

class UpdateShoppingListCommandHandler extends CommandHandlerInterface<UpdateShoppingListCommand, void> {
  UpdateShoppingListCommandHandler(this.ref);

  final ProviderRef<UpdateShoppingListCommandHandler> ref;

  @override
  Future<Result<void>> call(UpdateShoppingListCommand command) async {
    final snapshot = ShoppingListSnapshot(id: command.id, name: command.name);

    final result = await Result.guard(
      () async => ref.read(Dependency.shoppingRepository).updateList(snapshot),
    );

    result.onSuccess(
      (_) => ref.invalidate(findShoppingListsQueryHandler),
    );

    return result;
  }
}
