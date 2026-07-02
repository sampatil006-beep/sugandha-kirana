import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product_model.dart';
import '../providers/product_provider.dart';
import 'product_details_dialog.dart';

class ProductSearchScreen extends ConsumerStatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  ConsumerState<ProductSearchScreen> createState() =>
      _ProductSearchScreenState();
}

class _ProductSearchScreenState
    extends ConsumerState<ProductSearchScreen> {
  final TextEditingController _searchController =
  TextEditingController();

  List<ProductModel> _products = [];
  List<ProductModel> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();

    _searchController.addListener(() {
      _searchProducts(_searchController.text);
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

  void _searchProducts(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        _filteredProducts = _products;
      });
      return;
    }

    setState(() {
      _filteredProducts = _products.where((product) {
        return product.name
            .toLowerCase()
            .contains(value.toLowerCase()) ||
            (product.barcode ?? "")
                .toLowerCase()
                .contains(value.toLowerCase());
      }).toList();
    });
  }

  Widget _priceRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Products"),
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
              child: Text("No Product Found"),
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
                                final repo = ref.read(
                                    productRepositoryProvider);

                                await repo.deleteProduct(
                                    product.id!);

                                if (context.mounted) {
                                  Navigator.pop(
                                      context, true);
                                }
                              },
                            ),
                      );

                      if (result == true) {
                        _loadProducts();
                      }
                    },
                    title: Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        _priceRow(
                          "Sale",
                          "₹${product.sellingPrice}",
                        ),
                        _priceRow(
                          "Purchase",
                          "₹${product.purchasePrice}",
                        ),
                        _priceRow(
                          "MRP",
                          "₹${product.mrp}",
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(product.unit),
                        if (product.isLooseItem)
                          const Text(
                            "Loose",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 11,
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