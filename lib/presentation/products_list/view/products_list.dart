// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/theme/theme.dart';
import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/presentation/products_list/presenter/products_list.dart';
import 'package:peristock/presentation/products_list/view/components/create_product_action.dart';
import 'package:peristock/presentation/shared/layouts/layouts.dart';
import 'package:peristock/presentation/shared/widgets/widgets.dart';

final _productProvider = Provider<Product>((ref) => throw UnimplementedError());

class ProductsListView extends HookConsumerWidget {
  const ProductsListView({super.key});

  static const String path = '/products';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalItems = ref.watch(ProductsListPresenter.productsCount);

    return Scaffold(
      body: totalItems.when(
        data: (_) => const ProductsListLayout(),
        error: ErrorLayout.new,
        loading: LoadingLayout.new,
      ),
    );
  }
}

class ProductsListLayout extends ConsumerWidget {
  const ProductsListLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          toolbarHeight: 80,
          title: Text('Stock'),
          actions: [
            CreateProductActionButton(size: Size.square(48)),
          ],
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.regular),
          sliver: const ProductsList(),
        ),
      ],
    );
  }
}

class ProductsList extends ConsumerWidget {
  const ProductsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalItems = ref.watch(ProductsListPresenter.productsCount);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = ref.watch(ProductsListPresenter.indexedProduct(index));

          return product.whenOrNull(
            data: (product) => ProviderScope(
              overrides: [_productProvider.overrideWithValue(product)],
              child: const ProductListTile(),
            ),
          );
        },
        childCount: totalItems.value ?? 0,
      ),
    );
  }
}

class ProductListTile extends ConsumerWidget {
  const ProductListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final product = ref.watch(_productProvider);

    return InkWell(
      onTap: () {
        context.go('/products/${product.id}');
        // context.goNamed('ReadProduct', params: {'id': '${product.id}'});
      },
      child: Container(
        margin: EdgeInsets.only(top: theme.spacing.regular),
        clipBehavior: Clip.antiAlias,
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
        child: Slidable(
          key: ValueKey(product.id),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) async {
                  await ref.read(
                    ProductsListPresenter.deleteProduct(product.id).future,
                  );
                },
                backgroundColor: Palette.red500,
                foregroundColor: Palette.red50,
                icon: Icons.delete,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.big,
              vertical: theme.spacing.regular,
            ),
            child: Row(
              children: [
                Picture(
                  image: product.image,
                  size: const Size.square(45),
                ),
                Gap(theme.spacing.regular),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name, style: theme.textTheme.bodyLarge),
                      Gap(theme.spacing.small / 2),
                      Text('Quantité: ${product.quantity}', style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                const DaysLeft(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DaysLeft extends ConsumerWidget {
  const DaysLeft({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final bestBeforeDate = ref.watch(_productProvider).bestBeforeDate;
    final daysLeft = bestBeforeDate.difference(DateTime.now()).inDays;
    final color = daysLeft > 1 ? Palette.green600 : Palette.red600;

    return Text(
      '$daysLeft jours',
      style: theme.textTheme.bodySmall?.copyWith(color: color),
    );
  }
}
