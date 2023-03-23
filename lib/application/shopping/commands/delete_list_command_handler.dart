import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/di.dart';
import 'package:peristock/application/shared/command.dart';
import 'package:peristock/application/shared/result.dart';
import 'package:peristock/application/shopping/commands/delete_list_command.dart';
import 'package:peristock/application/shopping/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class DeleteShoppingListCommandHandler extends CommandHandlerInterface<DeleteShoppingListCommand, void> {
  DeleteShoppingListCommandHandler(this.ref);

  final ProviderRef<DeleteShoppingListCommandHandler> ref;

  @override
  Future<Result<void>> call(DeleteShoppingListCommand command) async {
    final result = await Result.guard(
      () async => ref.read(Dependency.shoppingRepository).deleteList(command.item),
    );

    result.onSuccess(
      (_) => ref.invalidate(findShoppingListsQueryHandler),
    );

    return result;
  }
}
