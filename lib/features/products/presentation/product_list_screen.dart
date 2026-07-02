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

    _searchController.addListener(() {
      _search(_searchController.text);
    });
  }

  Future<void> _loadProducts() async {
    final repo = ref.read(productRepositoryProvider);

    final data = await repo.getAllProducts();

    if (!mounted) return;

    setState(() {
      _products = data;
      _filteredProducts = data;
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

    await _loadProducts();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product.name} deleted"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddProductScreen(),
            ),
          );

          if (result == true) {
            _loadProducts();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search Product",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _filteredProducts.isEmpty
                ? const Center(
              child: Text("No Products Found"),
            )
                : ListView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product =
                _filteredProducts[index];

                return Card(
                  margin:
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    onTap: () async {
                      final result =
                      await showDialog<bool>(
                        context: context,
                        builder: (_) =>
                            ProductDetailsDialog(
                              product: product,
                              onDelete: () async {
                                Navigator.pop(
                                    context, true);
                                await _deleteProduct(
                                    product);
                              },
                            ),
                      );

                      if (result == true) {
                        _loadProducts();
                      }
                    },
                    title: Text(product.name),
                    subtitle: Text(
                      "Purchase ₹${product.purchasePrice} | Sale ₹${product.sellingPrice}",
                    ),
                    trailing: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          product.unit,
                          style: const TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                        if (product.isLooseItem)
                          const Text(
                            "Loose",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                      ],
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