import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/presentation/products/search/presenter/presenter.dart';
import 'package:peristock/presentation/shared/shared.dart';
import 'package:peristock/presentation/shared/widgets/thumbnail.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

Future<ProductSnapshot?> searchProducts(BuildContext context) {
  return showSearch(context: context, delegate: SearchProductDelegate());
}

class SearchProductDelegate extends SearchDelegate<ProductSnapshot> {
  SearchProductDelegate();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          Navigator.of(context).push(ProductFiltersLayout.route);
        },
        icon: const Icon(PhosphorIcons.funnelSimple),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => null;

  @override
  Widget buildResults(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final products = ref.watch(searchProductsProvider(query));

        return products.when(
          data: (value) => ResultsLayout(products: value, onSelected: (product) => close(context, product)),
          error: ErrorLayout.new,
          loading: LoadingLayout.new,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}

class ResultsLayout extends StatelessWidget {
  const ResultsLayout({
    required this.products,
    super.key,
    this.onSelected,
  });

  final List<ProductSnapshot> products;

  final void Function(ProductSnapshot product)? onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final product = products[index];

        return ListTile(
          leading: Thumbnail(child: product.image != null ? Image.network(product.image!, fit: BoxFit.fill) : null),
          title: Text(product.name ?? 'unknown'),
          onTap: () => onSelected?.call(products[index]),
        );
      },
      itemCount: products.length,
    );
  }
}

class ProductFiltersLayout extends StatelessWidget {
  const ProductFiltersLayout({super.key});

  static Route<void> get route {
    return CupertinoPageRoute<void>(builder: (_) => const ProductFiltersLayout());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Unfocus(
      child: Theme(
        data: theme.copyWith(
          inputDecorationTheme: theme.inputDecorationTheme.copyWith(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintStyle: theme.textTheme.titleMedium!.copyWith(fontSize: 13),
          ),
          listTileTheme: const ListTileThemeData(
            dense: true,
          ),
          expansionTileTheme: ExpansionTileThemeData(
            collapsedBackgroundColor: theme.inputDecorationTheme.fillColor,
          ),
        ),
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Filters'),
                centerTitle: true,
                titleTextStyle: theme.textTheme.bodyLarge,
              ),
              const SliverList(
                delegate: SliverChildListDelegate.fixed([
                  BrandFormField(),
                  Gap(16),
                  StoreFormField(),
                  Gap(16),
                  NutriscoreFormField(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NutriscoreFormField extends ConsumerWidget {
  const NutriscoreFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filtersProvider);

    return ExpansionTile(
      title: const Text('Nutriscore'),
      children: [
        for (final nutriscore in Nutriscore.values)
          CheckboxListTile(
            value: state.nutriscore == nutriscore,
            onChanged: (selected) {
              final notifier = ref.read(filtersProvider.notifier);
              // ignore: prefer-conditional-expressions
              if (selected ?? false) {
                notifier.state = state.copyWith(nutriscore: nutriscore);
              } else {
                notifier.state = state.copyWith(nutriscore: null);
              }
            },
            title: Text(nutriscore.name.toUpperCase()),
          ),
      ],
    );
  }
}

class BrandFormField extends HookConsumerWidget {
  const BrandFormField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(
      text: ref.read(filtersProvider).brand,
    );

    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Marque',
      ),
      onChanged: (value) {
        final filters = ref.read(filtersProvider);
        ref.read(filtersProvider.notifier).state = filters.copyWith(brand: value);
      },
    );
  }
}

class StoreFormField extends HookConsumerWidget {
  const StoreFormField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(
      text: ref.read(filtersProvider).store,
    );

    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Magasin',
      ),
      onChanged: (value) {
        final filters = ref.read(filtersProvider);
        ref.read(filtersProvider.notifier).state = filters.copyWith(store: value);
      },
    );
  }
}
