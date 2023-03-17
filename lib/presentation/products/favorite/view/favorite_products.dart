import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/presentation/products/search/view/search_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FavoriteProductsView extends ConsumerWidget {
  const FavoriteProductsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Products'),
          actions: [
            IconButton(
              icon: const Icon(PhosphorIcons.magnifyingGlass),
              onPressed: () => searchProducts(context),
            ),
          ],
        ),
      ],
    );
  }
}