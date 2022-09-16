part of 'products_views.dart';

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
        productSnapshotProvider.overrideWithValue(
          EditProductProcessor(product: product),
        ),
      ],
      child: const EditProductLayout(),
    );
  }
}

class EditProductLayout extends ConsumerWidget {
  const EditProductLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        title: const Text('Product'),
      ),
      body: const ProductForm(),
    );
  }
}
