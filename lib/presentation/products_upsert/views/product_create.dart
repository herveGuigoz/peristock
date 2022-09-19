import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/presentation/products_list/presenter/products_list.dart';
import 'package:peristock/presentation/products_upsert/presenter/presenter.dart';
import 'package:peristock/presentation/products_upsert/views/product_form.dart';

class CreateProductView extends ConsumerWidget {
  const CreateProductView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ProductForm>(ProductFormPresenter.state, (_, state) {
      state.status.whenOrNull(
        submissionSucceed: () {
          ProductsListPresenter.refreshList(ref);
          ref.read(ProductFormPresenter.state.notifier).resetForm();
        },
        submissionFailled: (err) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.toString())),
        ),
      );
    });

    return const CreateProductLayout();
  }
}

class CreateProductLayout extends ConsumerWidget {
  const CreateProductLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        title: const Text('Product'),
      ),
      body: const ProductFormLayout(),
    );
  }
}
