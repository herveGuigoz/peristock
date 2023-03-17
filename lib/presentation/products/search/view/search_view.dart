import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/presentation/products/search/presenter/presenter.dart';
import 'package:peristock/presentation/shared/shared.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';
import 'package:peristock/presentation/shared/widgets/thumbnail.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

Future<Product?> searchProducts(BuildContext context) async {
  return showSearch(context: context, delegate: SearchProductDelegate());
}

class SearchProductDelegate extends SearchDelegate<Product> {
  SearchProductDelegate();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(PhosphorIcons.funnelSimple),
        onPressed: () {
          Navigator.of(context).push(ProductFilters.route);
        },
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
          data: (value) => ResultsLayout(products: value),
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
    super.key,
    required this.products,
    this.onSelected,
  });

  final List<Product> products;

  final void Function(Product product)? onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => ListTile(
        leading: Thumbnail(
          child: products[index].image != null ? Image.network(products[index].image!, fit: BoxFit.fill) : null,
        ),
        title: Text(products[index].name),
        onTap: () => onSelected?.call(products[index]),
      ),
    );
  }
}

class ProductFilters extends ConsumerWidget {
  const ProductFilters({super.key});

  static Route<void> get route {
    return CupertinoPageRoute<void>(builder: (_) => const ProductFilters());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Unfocus(
      child: Scaffold(
        body: ListTileTheme(
          data: const ListTileThemeData(dense: true),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Filters'),
                centerTitle: true,
                titleTextStyle: theme.textTheme.bodyLarge,
              ),
              const SliverList(
                delegate: SliverChildListDelegate.fixed([
                  Nutriscore(),
                  Gap(16),
                  Additifs(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Additifs extends StatelessWidget {
  const Additifs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Additifs'),
      children: [
        CheckboxListTile(
          value: false,
          onChanged: (_) {},
          title: const Text('Sans'),
        ),
        CheckboxListTile(
          value: false,
          onChanged: (_) {},
          title: const Text('Avec'),
        ),
      ],
    );
  }
}

class Nutriscore extends StatelessWidget {
  const Nutriscore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Nutriscore'),
      children: [
        CheckboxListTile(
          value: false,
          onChanged: (_) {},
          title: const Text('A'),
        ),
        CheckboxListTile(
          value: false,
          onChanged: (_) {},
          title: const Text('B'),
        ),
        CheckboxListTile(
          value: false,
          onChanged: (_) {},
          title: const Text('C'),
        ),
        CheckboxListTile(
          value: false,
          onChanged: (_) {},
          title: const Text('D'),
        ),
        CheckboxListTile(
          value: false,
          onChanged: (_) {},
          title: const Text('E'),
        ),
      ],
    );
  }
}

class Brand extends StatelessWidget {
  const Brand({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(theme.spacing.regular),
      child: const TextField(
        decoration: InputDecoration(
          isDense: true,
          labelText: 'Marque',
        ),
      ),
    );
  }
}
