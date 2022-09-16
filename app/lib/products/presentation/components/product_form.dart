import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/app/theme/theme.dart';
import 'package:peristock/l10n.dart';
import 'package:peristock/products/domain/entities/entities.dart';
import 'package:peristock/products/presentation/processors/processors.dart';
import 'package:peristock/shared/presentation/extensions/extensions.dart';
import 'package:peristock/shared/presentation/hooks/hooks.dart';
import 'package:peristock/shared/presentation/widgets/widgets.dart';

class ProductForm extends ConsumerWidget {
  const ProductForm({
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
    final product = ref.watch(productSnapshotProvider);
    final image = product.image ?? product.asset;

    return Picture(
      image: image,
      decoration: BoxDecoration(
        border: Border.all(color: Palette.gray200),
        borderRadius: BorderRadius.all(theme.radius.regular),
      ),
      fit: BoxFit.fill,
      onTap: () {
        ref.watch(productSnapshotProvider.notifier).pickImage();
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
      create: () => ref.read(productSnapshotProvider).name,
      onChange: (input) {
        ref.watch(productSnapshotProvider.notifier).setName(input);
      },
    );

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
    final date = ref.watch(
      productSnapshotProvider.select((value) => value.bestBeforeDate),
    );
    final locale = context.l10n.localeName;
    final dateString = (date ?? DateTime.now()).format(locale);

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.gray200,
            foregroundColor: Palette.gray800,
          ),
          onPressed: () => showDatePicker(
            context: context,
            initialDate: date ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: (date ?? DateTime.now()) + 1825.days,
            locale: Locale(locale),
          ).then((value) {
            ref.read(productSnapshotProvider.notifier).setBestBeforeDate(value);
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
    final theme = Theme.of(context);

    final currentValue = ref.watch(
      productSnapshotProvider.select((value) => value.quantityType),
    );

    final inputController = useTextController(
      create: () => '1',
      onChange: (_) {},
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: inputController,
          decoration: const InputDecoration(isDense: true),
          enableSuggestions: false,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
        ),
        Gap(theme.spacing.regular),
        SizedBox(
          width: double.infinity,
          child: CupertinoSlidingSegmentedControl<QuantityType>(
            children: {
              for (final value in QuantityType.values) value: Text(value.name),
            },
            groupValue: currentValue,
            onValueChanged: (QuantityType? qt) {
              if (qt != null) {
                ref.read(productSnapshotProvider.notifier).setQuantityType(qt);
              }
            },
          ),
        ),
      ],
    );
  }
}

class SubmitButton extends ConsumerWidget {
  const SubmitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
      ),
      onPressed: () async {
        final container = ProviderScope.containerOf(context, listen: false);
        final processor = ref.read(productSnapshotProvider.notifier);
        final result = await processor.submitForm(container);

        result.when(
          data: (_) => context.pop(),
          error: (error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          ),
        );
      },
      child: const Text('Enregistrer'),
    );
  }
}

class FormCard extends StatelessWidget {
  const FormCard({
    super.key,
    required this.title,
    this.children = const [],
  });

  final Widget title;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: theme.spacing.small),
          child: title,
        ),
        Gap(theme.spacing.small),
        Container(
          padding: EdgeInsets.all(theme.spacing.big),
          decoration: BoxDecoration(
            color: Palette.white,
            borderRadius: BorderRadius.all(theme.radius.regular),
            boxShadow: const [
              BoxShadow(
                color: Palette.gray200,
                offset: Offset(4, 4),
                blurRadius: 8,
                spreadRadius: 2,
              ), //BoxShadow
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(theme.spacing.regular),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
