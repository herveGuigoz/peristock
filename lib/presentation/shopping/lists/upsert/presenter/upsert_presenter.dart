import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/domain/shared/result.dart';
import 'package:peristock/domain/providers/shopping.dart';
import 'package:peristock/presentation/shared/shared.dart';

part 'upsert_presenter.freezed.dart';

typedef UpsertPresenterProvider = AutoDisposeNotifierProvider<_UpsertListNotifier, UpsertListState>;

abstract class ShoppingListFormPresenter {
  static UpsertPresenterProvider get state => _upsertPresenterProvider;
}

final _upsertPresenterProvider = UpsertPresenterProvider(_UpsertListNotifier.new);

@freezed
class UpsertListState with _$UpsertListState, FormMixin {
  const factory UpsertListState({
    required ListName name,
    @Default(FormStatus.initial()) FormStatus status,
  }) = _UpsertListState;

  const UpsertListState._();

  @override
  List<FormInput<Object>?> get inputs => [name];
}

class ListName extends FormInput<String> {
  const ListName(super.value) : super(isPure: false);

  const ListName.initial(super.value) : super(isPure: true);

  @override
  String? validator(String value) => value.isEmpty ? 'Name cannot be empty' : null;
}

class _UpsertListNotifier extends AutoDisposeNotifier<UpsertListState> {
  _UpsertListNotifier([this._initialList]);

  final ShoppingList? _initialList;

  @override
  UpsertListState build() {
    return UpsertListState(name: ListName.initial(_initialList?.name ?? ''));
  }

  void updateName(String value) {
    final name = ListName(value);
    state = state.copyWith(name: name);
  }

  Future<void> submit() async {
    if (state.isPure || !state.isValid) {
      return;
    }

    state = state.copyWith(status: const FormStatus.submissionInProgress());

    final snapshot = ShoppingListSnapshot(
      id: _initialList?.id,
      name: state.name.value,
    );

    final result = await Result.guard(() async {
      return ref.read(shoppingListsProvider.notifier).createNewList(snapshot);
    });

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
