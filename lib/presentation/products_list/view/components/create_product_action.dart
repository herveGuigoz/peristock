// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/presentation/products_details/presenter/product.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';

enum CreateProductAction { scan, manual }

class CreateProductActionButton extends ConsumerWidget {
  const CreateProductActionButton({
    super.key,
    required this.size,
  });

  final Size size;

  Future<void> scanProduct(BuildContext context, WidgetRef ref) async {
    final code = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      false,
      ScanMode.BARCODE,
    );

    try {
      final product = await ref.read(
        ProductPresenter.searchProductByCode(code).future,
      );
      context.goNamed('EditProduct', extra: product);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    }
  }

  void createProduct(BuildContext context) {
    context.goNamed('CreateProduct');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return PopupMenuButton<CreateProductAction>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(theme.radius.regular),
      ),
      position: PopupMenuPosition.under,
      onSelected: (action) {
        if (action == CreateProductAction.scan) {
          scanProduct(context, ref);
        } else {
          createProduct(context);
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: CreateProductAction.scan,
          child: Text('Scan'),
        ),
        PopupMenuItem(
          value: CreateProductAction.manual,
          child: Text('Saisie'),
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: Icon(Icons.add),
      ),
    );
  }
}
