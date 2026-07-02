import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product_model.dart';
import '../providers/product_provider.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  final ProductModel? product;

  const AddProductScreen({
    super.key,
    this.product,
  });

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _barcodeController;
  late final TextEditingController _purchaseController;
  late final TextEditingController _sellingController;
  late final TextEditingController _mrpController;

  String _unit = "Piece";
  bool _isLooseItem = false;

  bool get isEdit => widget.product != null;

  @override
  void initState() {
    super.initState();

    final p = widget.product;

    _nameController = TextEditingController(text: p?.name ?? "");
    _barcodeController = TextEditingController(text: p?.barcode ?? "");
    _purchaseController =
        TextEditingController(text: p?.purchasePrice.toString() ?? "");
    _sellingController =
        TextEditingController(text: p?.sellingPrice.toString() ?? "");
    _mrpController =
        TextEditingController(text: p?.mrp.toString() ?? "");

    if (p != null) {
      _unit = p.unit;
      _isLooseItem = p.isLooseItem;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _barcodeController.dispose();
    _purchaseController.dispose();
    _sellingController.dispose();
    _mrpController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(productRepositoryProvider);

    final model = ProductModel(
      id: widget.product?.id,
      name: _nameController.text.trim(),
      barcode: _barcodeController.text.trim().isEmpty
          ? null
          : _barcodeController.text.trim(),
      purchasePrice: double.parse(_purchaseController.text),
      sellingPrice: double.parse(_sellingController.text),
      mrp: double.parse(_mrpController.text),
      unit: _unit,
      isLooseItem: _isLooseItem,
      stock: widget.product?.stock ?? 0,
      createdAt: widget.product?.createdAt,
      updatedAt: DateTime.now(),
    );

    if (isEdit) {
      await repo.updateProduct(model);
    } else {
      await repo.addProduct(model);
    }

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Product" : "Add Product"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Product Name"),
              validator: (v) =>
              v == null || v.trim().isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _barcodeController,
              decoration: const InputDecoration(labelText: "Barcode"),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _purchaseController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Purchase Price"),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _sellingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Selling Price"),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _mrpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "MRP"),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _unit,
              decoration: const InputDecoration(labelText: "Unit"),
              items: const [
                DropdownMenuItem(value: "Piece", child: Text("Piece")),
                DropdownMenuItem(value: "Kg", child: Text("Kg")),
                DropdownMenuItem(value: "Gram", child: Text("Gram")),
                DropdownMenuItem(value: "Litre", child: Text("Litre")),
                DropdownMenuItem(value: "ML", child: Text("ML")),
              ],
              onChanged: (v) => setState(() => _unit = v!),
            ),
            SwitchListTile(
              value: _isLooseItem,
              title: const Text("Loose Item"),
              onChanged: (v) => setState(() => _isLooseItem = v),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _save,
              child: Text(isEdit ? "Update Product" : "Save Product"),
            )
          ],
        ),
      ),
    );
  }
}
