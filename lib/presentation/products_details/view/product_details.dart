import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/presentation/products_details/presenter/product.dart';
import 'package:peristock/presentation/products_list/presenter/products_list.dart';
import 'package:peristock/presentation/shared/layouts/layouts.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';
import 'package:peristock/presentation/shared/widgets/widgets.dart';

final _product = Provider<Product>(
  (_) => throw UnimplementedError(),
  name: 'ProductDetailsView.product',
);

class ProductDetailsView extends ConsumerWidget {
  const ProductDetailsView({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(ProductPresenter.searchProductById(id));

    return Material(
      child: product.when(
        error: ErrorLayout.new,
        loading: LoadingLayout.new,
        data: (value) => ProviderScope(
          overrides: [_product.overrideWithValue(value)],
          child: const ProductDetailsLayout(),
        ),
      ),
    );
  }
}

class ProductDetailsLayout extends ConsumerWidget {
  const ProductDetailsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final product = ref.watch(_product);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.regular),
            child: const EditButton(),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(theme.spacing.regular),
        decoration: BoxDecoration(
          color: theme.palette.primaryContainer,
          borderRadius: BorderRadius.all(theme.radius.regular),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(theme.spacing.regular),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Picture(image: product.image),
                  Gap(theme.spacing.big),
                  const ProductName(),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.all(theme.spacing.regular),
              child: Row(
                children: [
                  const Expanded(child: DeleteButton()),
                  Gap(theme.spacing.small),
                  const Expanded(child: AddToFavoriteButton()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditButton extends ConsumerWidget {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(_product);

    return TextButton(
      onPressed: () {
        context.pushNamed('EditProduct', extra: product);
      },
      child: const Text('Modifier'),
    );
  }
}

class ProductName extends ConsumerWidget {
  const ProductName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final product = ref.watch(_product);

    return Text(
      product.name,
      style: TextStyle(
        fontSize: 24,
        color: theme.colorScheme.primary,
      ),
    );
  }
}

class AddToFavoriteButton extends StatelessWidget {
  const AddToFavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        backgroundColor: theme.palette.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      onPressed: () {},
      child: const AutoSizeText(
        'Ajouter aux favoris',
        maxLines: 1,
      ),
    );
  }
}

class DeleteButton extends ConsumerWidget {
  const DeleteButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(_product);
    final theme = Theme.of(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        backgroundColor: theme.colorScheme.errorContainer,
      ),
      onPressed: () async {
        final result = await ref.watch(
          ProductsListPresenter.deleteProduct(product.id).future,
        );

        result.map(
          success: (_) => context.pop(),
          failure: (failure) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failure.error.toString())),
          ),
        );
      },
      child: const AutoSizeText(
        'Retirer du stock',
        maxLines: 1,
      ),
    );
  }
}
