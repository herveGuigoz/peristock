part of 'products_views.dart';

class CreateProductView extends StatelessWidget {
  const CreateProductView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        productSnapshotProvider.overrideWithValue(
          CreateProductProcessor(),
        ),
      ],
      child: const CreateProductLayout(),
    );
  }
}

class CreateProductLayout extends StatelessWidget {
  const CreateProductLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        title: const Text('Product'),
      ),
      body: const ProductForm(),
    );
  }
}
