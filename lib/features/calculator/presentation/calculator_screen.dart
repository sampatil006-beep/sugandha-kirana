import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/data/product_model.dart';
import '../../products/providers/product_provider.dart';
import 'package:flutter/services.dart';

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
  List<ProductModel> _products = [];
  double _result = 0;
  bool amountToWeight = true;

  @override
  void initState() {
    super.initState();
    _product = widget.selectedProduct;

    ref.listenManual(productsProvider, (previous, next) {
      next.whenData((products) {
        final looseProducts =
        products.where((e) => e.isLooseItem).toList();

        looseProducts.sort(
              (a, b) => a.name.toLowerCase().compareTo(
            b.name.toLowerCase(),
          ),
        );

        if (!mounted) return;

        setState(() {
          _products = looseProducts;

          if (_products.isEmpty) {
            _product = null;
            return;
          }

          if (_product == null) {
            _product = _products.first;
            return;
          }

          _product = _products.firstWhere(
                (e) => e.id == _product!.id,
            orElse: () => _products.first,
          );
        });
      });
    });

    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final list =
    await ref.read(productRepositoryProvider).getAllProducts();
    debugPrint("Total Products: ${list.length}");
    debugPrint("Loose Products: ${list.where((e) => e.isLooseItem).length}");

    _products = list.where((e) => e.isLooseItem).toList();

    _products.sort(
          (a, b) => a.name.toLowerCase().compareTo(
        b.name.toLowerCase(),
      ),
    );

    if (_products.isNotEmpty) {
      if (_product == null) {
        _product = _products.first;
      } else {
        _product = _products.firstWhere(
              (e) => e.id == _product!.id,
          orElse: () => _products.first,
        );
      }
    }

    if (mounted) {
      setState(() {});
    }
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

  List<double> get quickValues {
    if (amountToWeight) {
      return [10, 20, 30, 50, 100];
    }

    return [50, 100, 250, 500, 750];
  }

  void selectQuickValue(double value) {
    _valueController.text = value.toStringAsFixed(0);
    calculate();
  }

  @override
  Widget build(BuildContext context) {
    if (_product == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF4FAF5),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Loose Product Calculator",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: _products.isEmpty
              ? const Text(
            "No loose products found.\nPlease add a loose product first.",
            textAlign: TextAlign.center,
          )
              : const CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4FAF5),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Calculator",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              20,
            ),
            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButtonFormField<ProductModel>(
                value: _products.contains(_product) ? _product : null,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: "Loose Product",
                  prefixIcon: Icon(Icons.inventory_2_outlined),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                items: _products.map((product) {
                  return DropdownMenuItem<ProductModel>(
                    value: product,
                    child: Text(
                      "${product.name}   ₹${product.sellingPrice}/${product.unit}",
                    ),
                  );
                }).toList(),
                onChanged: (product) {
                  if (product == null) return;

                  setState(() {
                    _product = product;
                  });

                  if (_valueController.text.isNotEmpty) {
                    calculate();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),



            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      setState(() {
                        amountToWeight = true;
                        _result = 0;
                        _valueController.clear();
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: amountToWeight
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "₹ → Gram",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: amountToWeight
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      setState(() {
                        amountToWeight = false;
                        _result = 0;
                        _valueController.clear();
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: !amountToWeight
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Gram → ₹",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !amountToWeight
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _valueController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9.]'),
                  ),
                ],
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    amountToWeight
                        ? Icons.currency_rupee
                        : Icons.scale_outlined,
                  ),
                  hintText: amountToWeight
                      ? "Enter Amount"
                      : "Enter Weight",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),

                onChanged: (_) {
                  calculate();
                  setState(() {});
                },

                onSubmitted: (_) => calculate(),
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: 52,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: quickValues.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final value = quickValues[index];

                  final selected =
                      _valueController.text == value.toStringAsFixed(0);

                  return InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      selectQuickValue(value);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: selected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        amountToWeight
                            ? "₹${value.toInt()}"
                            : "${value.toInt()} g",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selected
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            const SizedBox(height: 20),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 24,
              ),
              decoration: BoxDecoration(
                color: _result > 0
                    ? Colors.green.shade50
                    : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: _result > 0
                      ? Colors.green.shade200
                      : Colors.grey.shade200,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Result",
                    style: TextStyle(
                      fontSize: 15,
                      color: _result > 0
                          ? Colors.green.shade700
                          : Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    amountToWeight
                        ? "${_result.toStringAsFixed(0)} Gram"
                        : "₹${_result.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: _result > 0
                          ? Colors.green.shade800
                          : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
            ),
          ),
        ),
    );
  }
}
