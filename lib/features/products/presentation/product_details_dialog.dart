import 'package:flutter/material.dart';

import '../../calculator/presentation/calculator_screen.dart';
import '../data/product_model.dart';
import 'add_product_screen.dart';

class ProductDetailsDialog extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onDelete;

  const ProductDetailsDialog({
    super.key,
    required this.product,
    this.onDelete,
  });

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(product.name),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoRow("Purchase", "₹${product.purchasePrice}"),
            infoRow("Selling", "₹${product.sellingPrice}"),
            infoRow("MRP", "₹${product.mrp}"),
            infoRow("Unit", product.unit),
            infoRow(
              "Loose Item",
              product.isLooseItem ? "Yes" : "No",
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CalculatorScreen(
                  selectedProduct: product,
                ),
              ),
            );
          },
          child: const Text("Calculator"),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);

            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddProductScreen(
                  product: product,
                ),
              ),
            );

            if (result == true && context.mounted) {
              Navigator.pop(context, true);
            }
          },
          child: const Text("Edit"),
        ),
        TextButton(
          onPressed: onDelete,
          child: const Text(
            "Delete",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}