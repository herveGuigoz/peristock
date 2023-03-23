import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:peristock/application/logger/logger.dart';
import 'package:peristock/application/shopping/commands/create_list_command.dart';
import 'package:peristock/application/shopping/commands/update_list_command.dart';
import 'package:peristock/application/shopping/providers.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/presentation/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_presenter.freezed.dart';
part 'form_presenter.g.dart';
part 'form_state.dart';

@riverpod
class ListFormNotifier extends _$ListFormNotifier {
  ListFormNotifier([this._instance]);

  final ShoppingList? _instance;

  @override
  ShoppingListFormState build() {
    if (_instance == null) {
      return const ShoppingListFormState.create();
    }

    return ShoppingListFormState.edit(name: ListName.initial(_instance?.name ?? ''));
  }

  void updateName(String value) {
    final name = ListName(value);
    state = state.copyWith(name: name);
  }

  Future<void> submit() async {
    if (state.isPure || !state.isValid) {
      state.log();
      
      return;
    }

    state = state.copyWith(status: const FormStatus.submissionInProgress());

    final result = await state.map(
      create: (_)  {
        final command = CreateShoppingListCommand(name: state.name.value);

        return ref.read(createShoppingListCommandHandler)(command);
      },
      edit: (_)  {
        final command = UpdateShoppingListCommand(id: _instance!.id, name: state.name.value);

        return ref.read(updateShoppingListCommandHandler)(command);
      },
    );

    result.when(
      data: (_) {
        state = state.copyWith(status: const FormStatus.submissionSucceed());
      },
      error: (error) {
        state = state.copyWith(status: FormStatus.submissionFailled(error));
      },
    );
  }
}
