import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product_model.dart';
import '../providers/product_provider.dart';
import '../data/product_sync_service.dart';

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
  late final TextEditingController _purchaseController;
  late final TextEditingController _sellingController;

  String _unit = "Piece";
  bool _isLooseItem = false;

  bool get isEdit => widget.product != null;

  @override
  void initState() {
    super.initState();

    final p = widget.product;

    _nameController = TextEditingController(text: p?.name ?? "");
    _purchaseController =
        TextEditingController(text: p?.purchasePrice.toString() ?? "");
    _sellingController =
        TextEditingController(text: p?.sellingPrice.toString() ?? "");
    _purchaseController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _sellingController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (p != null) {
      _unit = p.unit;
      _isLooseItem = p.isLooseItem;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _purchaseController.dispose();
    _sellingController.dispose();
    super.dispose();
  }
  double get _profit {
    final purchase =
        double.tryParse(_purchaseController.text) ?? 0;

    final selling =
        double.tryParse(_sellingController.text) ?? 0;

    return selling - purchase;
  }

  double get _margin {
    final purchase =
        double.tryParse(_purchaseController.text) ?? 0;

    if (purchase <= 0) return 0;

    return (_profit / purchase) * 100;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(productRepositoryProvider);

    final model = ProductModel(
      id: widget.product?.id,
      uuid: widget.product?.uuid ?? '',
      name: _nameController.text.trim(),
      barcode: null,
      purchasePrice: double.parse(_purchaseController.text),
      sellingPrice: double.parse(_sellingController.text),
      mrp: 0,
      unit: _unit,
      isLooseItem: _isLooseItem,
      stock: widget.product?.stock ?? 0,
      isSynced: false,
      deletedAt: widget.product?.deletedAt,
      createdAt: widget.product?.createdAt,
      updatedAt: DateTime.now(),
    );

    if (isEdit) {
      await repo.updateProduct(model);
    } else {
      await repo.addProduct(model);
    }
    await ref
        .read(productSyncRepositoryProvider)
        .syncPendingProducts();

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
              controller: _purchaseController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Purchase Price",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter Purchase Price";
                }

                if (double.tryParse(value) == null) {
                  return "Invalid Price";
                }

                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _sellingController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Selling Price",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter Selling Price";
                }

                if (double.tryParse(value) == null) {
                  return "Invalid Price";
                }

                return null;
              },
            ),
            Card(
              color: _profit > 0
                  ? Colors.green.shade50
                  : _profit < 0
                  ? Colors.red.shade50
                  : Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Purchase : ₹${(double.tryParse(_purchaseController.text) ?? 0).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Selling   : ₹${(double.tryParse(_sellingController.text) ?? 0).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(height: 20),
                    Text(
                      "Profit : ₹${_profit.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _profit > 0
                            ? Colors.green
                            : _profit < 0
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Margin : ${_margin.toStringAsFixed(2)}%",
                      style: TextStyle(
                        fontSize: 16,
                        color: _profit > 0
                            ? Colors.green
                            : _profit < 0
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _unit,
              decoration: const InputDecoration(labelText: "Unit"),
              items: (_isLooseItem
                  ? const [
                DropdownMenuItem(value: "Kg", child: Text("Kg")),
                DropdownMenuItem(value: "Gram", child: Text("Gram")),
                DropdownMenuItem(value: "Litre", child: Text("Litre")),
                DropdownMenuItem(value: "ML", child: Text("ML")),
              ]
                  : const [
                DropdownMenuItem(value: "Piece", child: Text("Piece")),
                DropdownMenuItem(value: "Packet", child: Text("Packet")),
                DropdownMenuItem(value: "Box", child: Text("Box")),
                DropdownMenuItem(value: "Bottle", child: Text("Bottle")),
                DropdownMenuItem(value: "Pouch", child: Text("Pouch")),
              ]),
              onChanged: (v) => setState(() => _unit = v!),
            ),
            SwitchListTile(
              value: _isLooseItem,
              title: const Text("Loose Item"),
              onChanged: (v) {
                setState(() {
                  _isLooseItem = v;

                  if (_isLooseItem) {
                    _unit = "Kg";
                  } else {
                    _unit = "Piece";
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _save,
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
