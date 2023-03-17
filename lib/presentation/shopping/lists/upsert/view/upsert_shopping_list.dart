import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';
import 'package:peristock/presentation/shopping/lists/upsert/presenter/upsert_presenter.dart';

class UpsertListModal extends ConsumerWidget {
  const UpsertListModal({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(context: context, builder: (_) => const UpsertListModal());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    ref.listen<UpsertListState>(ShoppingListFormPresenter.state, (curr, next) {
      if (next.status.isSucceed) {
        Navigator.of(context).pop();
      }
    });

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.regular),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text('New list'),
            ),
            Gap(theme.spacing.regular),
            const ListNameFormField(),
            Gap(theme.spacing.regular),
            const ButtonBar(
              children: [
                CancelButton(),
                SubmitButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListNameFormField extends ConsumerWidget {
  const ListNameFormField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error = ref.watch(
      ShoppingListFormPresenter.state.select((value) => value.name.error),
    );

    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'Name',
        errorText: error,
      ),
      onChanged: (value) => ref.read(ShoppingListFormPresenter.state.notifier).updateName(value),
    );
  }
}

class CancelButton extends ConsumerWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('Cancel'),
    );
  }
}

class SubmitButton extends ConsumerWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => ref.read(ShoppingListFormPresenter.state.notifier).submit(),
      child: const Text('Create'),
    );
  }
}
