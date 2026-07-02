import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/data/product_model.dart';
import '../../products/providers/product_provider.dart';

class CalculatorScreen extends ConsumerStatefulWidget {
  final ProductModel? selectedProduct;

  const CalculatorScreen({
    super.key,
    this.selectedProduct,
  });

  @override
  ConsumerState<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends ConsumerState<CalculatorScreen> {
  final TextEditingController _valueController = TextEditingController();

  ProductModel? _product;
  double _result = 0;
  bool amountToWeight = true;

  @override
  void initState() {
    super.initState();
    _product = widget.selectedProduct;
  }

  void calculate() {
    if (_product == null) return;

    final value = double.tryParse(_valueController.text) ?? 0;
    final rate = _product!.sellingPrice;

    setState(() {
      if (amountToWeight) {
        _result = (value / rate) * 1000;
      } else {
        _result = (value / 1000) * rate;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Calculator")),
        body: Consumer(
          builder: (context, ref, _) {
            return FutureBuilder(
              future: ref.read(productRepositoryProvider).getAllProducts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final products = (snapshot.data as List<ProductModel>)
                    .where((e) => e.isLooseItem)
                    .toList();

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (_, i) {
                    final p = products[i];
                    return ListTile(
                      title: Text(p.name),
                      subtitle: Text("₹${p.sellingPrice}/${p.unit}"),
                      onTap: () {
                        setState(() {
                          _product = p;
                        });
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(_product!.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Rate : ₹${_product!.sellingPrice}/${_product!.unit}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text("₹ → Gram")),
                ButtonSegment(value: false, label: Text("Gram → ₹")),
              ],
              selected: {amountToWeight},
              onSelectionChanged: (s) {
                setState(() {
                  amountToWeight = s.first;
                  _result = 0;
                  _valueController.clear();
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: amountToWeight ? "Amount (₹)" : "Weight (Gram)",
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: calculate,
              child: const Text("Calculate"),
            ),
            const SizedBox(height: 24),
            Text(
              amountToWeight
                  ? "${_result.toStringAsFixed(0)} Gram"
                  : "₹${_result.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
