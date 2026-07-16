import '../../calculator/presentation/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product_model.dart';
import '../providers/product_provider.dart';
import 'add_product_screen.dart';
import 'product_details_dialog.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() =>
      _ProductListScreenState();
}

class _ProductListScreenState
    extends ConsumerState<ProductListScreen> {
  final TextEditingController _searchController =
  TextEditingController();

  List<ProductModel> _products = [];
  List<ProductModel> _filteredProducts = [];

  @override
  void initState() {
    super.initState();

    _loadProducts();

    ref.listenManual(productsProvider, (previous, next) {
      next.whenData((products) {
        if (!mounted) return;

        _products = [...products];

        _products.sort(
              (a, b) =>
              a.name.toLowerCase().compareTo(
                b.name.toLowerCase(),
              ),
        );

        _search(_searchController.text);
      });
    });

    _searchController.addListener(() {
      _search(_searchController.text);
    });
  }

  Future<void> _loadProducts() async {
    final repo = ref.read(productRepositoryProvider);

    final data = await repo.getAllProducts();

    if (!mounted) return;

    data.sort(
          (a, b) => a.name.toLowerCase().compareTo(
        b.name.toLowerCase(),
      ),
    );

    setState(() {
      _products = data;
      _search(_searchController.text);
    });
  }

  void _search(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        _filteredProducts = _products;
      });
      return;
    }

    setState(() {
      _filteredProducts = _products.where((e) {
        return e.name
            .toLowerCase()
            .contains(value.toLowerCase()) ||
            (e.barcode ?? "")
                .toLowerCase()
                .contains(value.toLowerCase());
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _deleteProduct(ProductModel product) async {
    final repo = ref.read(productRepositoryProvider);

    await repo.deleteProduct(product.id!);
    await ref
        .read(productSyncRepositoryProvider)
        .syncPendingProducts();



    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("${product.name} deleted"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAF5),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Products",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 6,
        icon: const Icon(Icons.add),
        label: const Text(
          "Add Product",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddProductScreen(),
            ),
          );

          if (result == true) {
            await _loadProducts();
          }
        },
      ),
      body: Column(
        children: [
      Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        8,
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search products...",
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isEmpty
              ? null
              : IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _searchController.clear();
            },
          ),
          filled: true,
          fillColor: Colors.white,
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
      ),
    ),
          Expanded(
            child: _filteredProducts.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.inventory_2_outlined,
                    size: 70,
                    color: Colors.grey.shade400,
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "No Products Found",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Tap 'Add Product' to create your first product.",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            )
            :ListView.builder(
              padding: const EdgeInsets.only(
                bottom: 90,
                top: 4,
              ),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product =
                _filteredProducts[index];

                return Card(
                  elevation: 3,
                  shadowColor: Colors.black.withValues(alpha: 0.08),
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (_) => ProductDetailsDialog(
                          product: product,
                          onDelete: () async {
                            Navigator.pop(context, true);
                            await _deleteProduct(product);
                          },
                        ),
                      );

                      if (result == true) {
                        await _loadProducts();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [

                          const SizedBox(width: 4),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Row(
                                  children: [

                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.shade50,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        "Purchase ₹${product.purchasePrice}",
                                        style: TextStyle(
                                          color: Colors.orange.shade700,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.green.shade200,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        "Sale ₹${product.sellingPrice}",
                                        style: TextStyle(
                                          color: Colors.green.shade700,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 2),
                              ],
                            ),
                          ),

                          product.isLooseItem
                              ? Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              splashRadius: 18,
                              iconSize: 22,
                              icon: Icon(
                                Icons.calculate_rounded,
                                color: Colors.green.shade700,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CalculatorScreen(
                                      selectedProduct: product,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}