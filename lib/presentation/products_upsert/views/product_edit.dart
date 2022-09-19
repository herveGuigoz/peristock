import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/entities/entities.dart';
import 'package:peristock/presentation/products_list/presenter/products_list.dart';
import 'package:peristock/presentation/products_upsert/presenter/presenter.dart';
import 'package:peristock/presentation/products_upsert/views/product_form.dart';

class EditProductView extends ConsumerWidget {
  const EditProductView({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        ProductFormPresenter.product.overrideWithValue(product),
      ],
      child: const EditProductLayout(),
    );
  }
}

class EditProductLayout extends ConsumerWidget {
  const EditProductLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ProductForm>(ProductFormPresenter.state, (_, state) {
      state.status.whenOrNull(
        submissionSucceed: () {
          ProductsListPresenter.refreshList(ref);
          context.go('/products');
        },
        submissionFailled: (err) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.toString())),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        title: const Text('Product'),
      ),
      body: const ProductFormLayout(),
    );
  }
}
