import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/l10n.dart';
import 'package:peristock/presentation/products_upsert/presenter/presenter.dart';
import 'package:peristock/presentation/shared/shared.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';

class ProductFormLayout extends ConsumerWidget {
  const ProductFormLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Unfocus(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(theme.spacing.regular),
          child: Column(
            children: [
              FormCard(
                title: const Text('ARTICLE'),
                children: [
                  const ProductPicture(),
                  Gap(theme.spacing.regular),
                  const ProductNameInput(),
                ],
              ),
              Gap(theme.spacing.big),
              const FormCard(
                title: Text('DATE LIMITE DE CONSOMATION'),
                children: [
                  BestBeforeDateInput(),
                ],
              ),
              Gap(theme.spacing.big),
              const FormCard(
                title: Text('QUANTITÉ'),
                children: [
                  ProductQuantityInput(),
                ],
              ),
              Gap(theme.spacing.big),
              const SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductPicture extends ConsumerWidget {
  const ProductPicture({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final image = ref.watch(
      ProductFormPresenter.state.select((state) => state.image),
    );

    return Picture(
      image: image?.value,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.tertiary),
        borderRadius: BorderRadius.all(theme.radius.regular),
      ),
      fit: image?.whenOrNull(
        asset: (_) => BoxFit.fill,
        network: (_) => BoxFit.scaleDown,
      ),
      onTap: () {
        ref.watch(ProductFormPresenter.state.notifier).pickImage();
      },
    );
  }
}

class ProductNameInput extends HookConsumerWidget {
  const ProductNameInput({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextController(
      create: () => ref.read(ProductFormPresenter.state).name.value,
      onChange: (input) {
        ref.watch(ProductFormPresenter.state.notifier).setName(input);
      },
    );

    ref.listen<ProductForm>(ProductFormPresenter.state, (_, state) {
      state.status.whenOrNull(
        submissionSucceed: () => controller.value = TextEditingValue.empty,
      );
    });

    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        isDense: true,
        hintText: 'Name',
      ),
    );
  }
}

class BestBeforeDateInput extends ConsumerWidget {
  const BestBeforeDateInput({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final date = ref.watch(
      ProductFormPresenter.state.select((state) => state.beforeDate.value),
    );
    final locale = context.l10n.localeName;
    final dateString = date.format(locale);

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.onSecondary,
            foregroundColor: theme.colorScheme.secondary,
          ),
          onPressed: () => showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime.now(),
            lastDate: date + 1825.days,
            locale: Locale(locale),
          ).then((value) {
            if (value == null) return;
            ref.read(ProductFormPresenter.state.notifier).setBestBeforeDate(value);
          }),
          child: Text(dateString),
        ),
      ),
    );
  }
}

class ProductQuantityInput extends HookConsumerWidget {
  const ProductQuantityInput({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = useTextController(
      create: () => '1',
      onChange: (input) => ref.read(ProductFormPresenter.state.notifier).setQuantity(int.parse(input)),
    );

    return TextField(
      controller: inputController,
      decoration: const InputDecoration(isDense: true),
      enableSuggestions: false,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
    );
  }
}

class SubmitButton extends ConsumerWidget {
  const SubmitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ProductFormPresenter.state);

    final isFormValid = state.status.maybeWhen(
      initial: () => state.isValid && !state.isPure,
      orElse: () => false,
    );

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
      ),
      onPressed: isFormValid ? () => ref.read(ProductFormPresenter.state.notifier).submitForm() : null,
      child: const Text('Enregistrer'),
    );
  }
}

class FormCard extends ConsumerWidget {
  const FormCard({
    super.key,
    required this.title,
    this.children = const [],
  });

  final Widget title;

  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(.15),
            offset: const Offset(4, 4),
            blurRadius: 8,
            spreadRadius: 2,
          ), //BoxShadow
        ],
      ),
      child: Material(
        type: MaterialType.card,
        shadowColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(theme.radius.regular),
        ),
        child: Padding(
          padding: EdgeInsets.all(theme.spacing.regular),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
