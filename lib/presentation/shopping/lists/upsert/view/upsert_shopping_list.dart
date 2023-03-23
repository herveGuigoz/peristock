import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';
import 'package:peristock/presentation/shopping/lists/upsert/presenter/form_presenter.dart';

class UpsertListModal extends ConsumerWidget {
  const UpsertListModal({
    super.key,
    this.instance,
  });

  static Future<void> show(BuildContext context, {ShoppingList? instance}) {
    return showDialog<void>(context: context, builder: (_) => UpsertListModal(instance: instance));
  }

  final ShoppingList? instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final spacing = theme.spacing.regular;

    return ProviderScope(
      overrides: [
        listFormNotifierProvider.overrideWith(() => ListFormNotifier(instance)),
      ],
      child: FormListener(
        child: Dialog(
          child: Padding(
            padding: EdgeInsets.all(spacing),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  title: Text('New list'),
                ),
                Gap(spacing),
                const ListNameFormField(),
                Gap(spacing),
                const ButtonBar(
                  children: [
                    CancelButton(),
                    SubmitButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormListener extends ConsumerWidget {
  const FormListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ShoppingListFormState>(listFormNotifierProvider, (curr, next) {
      next.status.mapOrNull(
        submissionSucceed: (value) {
          Navigator.of(context).pop();
        },
        submissionFailled: (value) {
          Navigator.of(context).pop();
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(content: Text(value.error.toString())));
        },
      );
    });

    return child;
  }
}

class ListNameFormField extends ConsumerWidget {
  const ListNameFormField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(
      listFormNotifierProvider.select((value) => value.name),
    );

    return TextFormField(
      initialValue: name.value,
      decoration: InputDecoration(labelText: 'Name', errorText: name.error),
      autofocus: true,
      onChanged: (value) => ref.read(listFormNotifierProvider.notifier).updateName(value),
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
    final state = ref.watch(listFormNotifierProvider);

    return ElevatedButton(
      onPressed: state.isPure || !state.isValid ? null : () => ref.read(listFormNotifierProvider.notifier).submit(),
      child: Text(state is CreateShoppingListFormState ? 'Create' : 'Update'),
    );
  }
}
