import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/logger/logger.dart';
import 'package:peristock/presentation/products/search/view/search_view.dart';
import 'package:peristock/presentation/shared/shared.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';
import 'package:peristock/presentation/shopping/items/upsert/presenter/form_presenter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateListItemView extends ConsumerWidget {
  const CreateListItemView({
    super.key,
    required this.id,
  });

  static const name = 'CreateListItemView';

  /// The id of the shopping list.
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

class EditListItemView extends ConsumerWidget {
  const EditListItemView({
    super.key,
    required this.id,
  });

  static const name = 'EditListItemView';

  /// The id of the shopping list item.
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

class UpsertListItemLayout extends ConsumerWidget {
  const UpsertListItemLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final spacing = theme.spacing.regular;

    ref.listen<ProductFormState>(productFormNotifierProvider, (previous, next) {
      next.status.whenOrNull(
        submissionSucceed: () => context.pop(),
        submissionFailled: (error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$error'))),
      );
    });

    return Unfocus(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Item'),
          actions: [
            IconButton(
              onPressed: () => searchProducts(context),
              icon: const Icon(PhosphorIcons.magnifyingGlass),
            ),
            IconButton(
              onPressed: () => 'Barcode'.log(),
              icon: const Icon(PhosphorIcons.barcode),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(spacing),
            child: Column(
              children: [
                const NameFormField(),
                Gap(spacing),
                const QuantityFormField(),
                Gap(spacing),
                const PriceFormField(),
                Gap(spacing),
                const NotesFormField(),
                Gap(theme.spacing.big),
                const SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NameFormField extends HookConsumerWidget {
  const NameFormField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(
      text: ref.read(productFormNotifierProvider).name.value,
    );

    final error = ref.watch(
      productFormNotifierProvider.select((value) => value.name.error),
    );

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Name',
        errorText: error,
      ),
      onChanged: (value) => ref.read(productFormNotifierProvider.notifier).nameChanged(value),
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
    );
  }
}

class QuantityFormField extends ConsumerWidget {
  const QuantityFormField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: const InputDecoration(hintText: 'Quantity'),
      keyboardType: TextInputType.number,
      onChanged: (value) => ref.read(productFormNotifierProvider.notifier).quantityChanged(value),
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
    );
  }
}

class PriceFormField extends ConsumerWidget {
  const PriceFormField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: const InputDecoration(hintText: 'Price'),
      keyboardType: TextInputType.number,
      onChanged: (value) => ref.read(productFormNotifierProvider.notifier).priceChanged(value),
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
    );
  }
}

class NotesFormField extends ConsumerWidget {
  const NotesFormField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: const InputDecoration(hintText: 'Notes'),
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      onChanged: (value) => ref.read(productFormNotifierProvider.notifier).noteChanged(value),
    );
  }
}

class SubmitButton extends ConsumerWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final isValid = ref.watch(
      productFormNotifierProvider.select((value) => value.isValid),
    );

    final status = ref.watch(
      productFormNotifierProvider.select((value) => value.status),
    );

    return ElevatedButton(
      onPressed:
          (!status.isInProgress && isValid) ? () => ref.read(productFormNotifierProvider.notifier).submit() : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        minimumSize: const Size.fromHeight(48),
      ),
      child: status.maybeWhen(submissionInProgress: () => const Text('Loading...'), orElse: () => const Text('Submit')),
    );
  }
}
