import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/di.dart';
import 'package:peristock/application/shared/command.dart';
import 'package:peristock/application/shared/result.dart';
import 'package:peristock/application/shopping/commands/create_list_command.dart';
import 'package:peristock/application/shopping/providers.dart';
import 'package:peristock/domain/entities/entities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class CreateShoppingListCommandHandler extends CommandHandlerInterface<CreateShoppingListCommand, void> {
  CreateShoppingListCommandHandler(this.ref);

  final ProviderRef<CreateShoppingListCommandHandler> ref;

  @override
  Future<Result<void>> call(CreateShoppingListCommand command) async {
    final snapshot = ShoppingListSnapshot(name: command.name);

    final result = await Result.guard(
      () async => ref.read(Dependency.shoppingRepository).createList(snapshot),
    );

    result.onSuccess(
      (_) => ref.invalidate(findShoppingListsQueryHandler),
    );
    
    return result;
  }
}
