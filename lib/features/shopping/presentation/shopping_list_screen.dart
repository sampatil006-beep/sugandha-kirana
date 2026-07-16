import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/shopping_item_model.dart';
import '../providers/shopping_provider.dart';
import 'add_shopping_item_dialog.dart';

class ShoppingListScreen extends ConsumerStatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  ConsumerState<ShoppingListScreen> createState() =>
      _ShoppingListScreenState();
}

class _ShoppingListScreenState
    extends ConsumerState<ShoppingListScreen> {
  final Map<String, bool> _expanded = {
    'Kirana': true,
    'Cold Drinks': true,
    'Snacks': true,
    'General': true,
    'Other': true,
  };

  final TextEditingController _searchController =
  TextEditingController();

  String _searchQuery = "";

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Kirana':
        return Icons.shopping_cart;

      case 'Cold Drinks':
        return Icons.local_drink;

      case 'Snacks':
        return Icons.cookie;

      case 'General':
        return Icons.inventory_2;

      default:
        return Icons.category;
    }
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'Kirana':
        return Colors.brown;

      case 'Cold Drinks':
        return Colors.blue;

      case 'Snacks':
        return Colors.orange;

      case 'General':
        return Colors.deepPurple;

      default:
        return Colors.teal;
    }
  }

  Map<String, List<ShoppingItemModel>> _groupItems(
      List<ShoppingItemModel> items,) {
    const categories = [
      'Kirana',
      'Cold Drinks',
      'Snacks',
      'General',
      'Other',
    ];

    final grouped = <String, List<ShoppingItemModel>>{};

    for (final category in categories) {
      final categoryItems = items
          .where((e) => e.category == category)
          .toList();

      categoryItems.sort((a, b) {
        if (a.isPurchased != b.isPurchased) {
          return a.isPurchased ? 1 : -1;
        }

        return a.name
            .toLowerCase()
            .compareTo(b.name.toLowerCase());
      });

      grouped[category] = categoryItems;
    }

    return grouped;
  }

  Future<void> _toggleItem(WidgetRef ref,
      ShoppingItemModel item,) async {
    await ref.read(shoppingRepositoryProvider).updateItem(
      item.copyWith(
        isPurchased: !item.isPurchased,
      ),
    );
    await ref
        .read(shoppingSyncRepositoryProvider)
        .syncPendingItems();
  }

  Future<void> _clearPurchased(WidgetRef ref) async {
    await ref
        .read(shoppingRepositoryProvider)
        .clearPurchasedItems();

    await ref
        .read(shoppingSyncRepositoryProvider)
        .syncPendingItems();
  }

  Future<void> _clearAll(WidgetRef ref) async {
    await ref
        .read(shoppingRepositoryProvider)
        .clearAllItems();

    await ref
        .read(shoppingSyncRepositoryProvider)
        .syncPendingItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shoppingAsync =
    ref.watch(shoppingItemsProvider);

    return shoppingAsync.when(
      loading: () =>
      const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),

      error: (e, _) =>
          Scaffold(
            appBar: AppBar(
              title: const Text("Shopping List"),
            ),
            body: Center(
              child: Text(e.toString()),
            ),
          ),

      data: (items) {
        final remaining = items
            .where((e) => !e.isPurchased)
            .length;

        final purchased = items
            .where((e) => e.isPurchased)
            .length;

        final groupedItems = _groupItems(items);

        return Scaffold(

          floatingActionButton:
          FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) =>
                const AddShoppingItemDialog(),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Item"),
          ),

          body: Column(
            children: [
              Card(
                margin: const EdgeInsets.fromLTRB(12, 44, 12, 2),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            color: Colors.green,
                          ),

                          const SizedBox(width: 8),

                          const Expanded(
                            child: Text(
                              "Shopping Summary",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          PopupMenuButton<String>(
                            onSelected: (value) async {
                              if (value == "clearPurchased") {
                                await _clearPurchased(ref);
                              }

                              if (value == "clearAll") {
                                final confirm =
                                await showDialog<bool>(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text(
                                      "Clear All Items",
                                    ),
                                    content: const Text(
                                      "Delete all shopping items?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                            false,
                                          );
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      FilledButton(
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                            true,
                                          );
                                        },
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  await _clearAll(ref);
                                }
                              }
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(
                                value: "clearPurchased",
                                child: Text("Clear Purchased"),
                              ),
                              PopupMenuItem(
                                value: "clearAll",
                                child: Text("Clear All"),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius:
                                BorderRadius.circular(14),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    "Remaining",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "$remaining Items",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius:
                                BorderRadius.circular(14),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    "Purchased",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "$purchased Items",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),


              Expanded(
                child: items.isEmpty
                    ? const Center(
                  child: Text(
                    "No Items",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
                    : ListView(
                  padding: const EdgeInsets.only(top: 2),
                  children:
                  groupedItems.entries
                      .map((entry) {
                    final category =
                        entry.key;

                    final categoryItems =
                        entry.value;

                    if (categoryItems
                        .isEmpty) {
                      return const SizedBox
                          .shrink();
                    }

                    return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _categoryColor(category).withOpacity(0.06),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ExpansionTile(
                        key:
                        PageStorageKey(
                          category,
                        ),
                        initiallyExpanded:
                        _expanded[
                        category] ??
                            true,

                        onExpansionChanged:
                            (value) {
                          setState(() {
                            _expanded[
                            category] =
                                value;
                          }
                          );
                        },

                            leading: CircleAvatar(
                              radius: 22,
                              backgroundColor:
                              _categoryColor(category).withOpacity(0.15),
                              child: Icon(
                                _categoryIcon(category),
                                color: _categoryColor(category),
                                size: 22,
                              ),
                            ),

                        title: Text(
                          category,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),

                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                            _categoryColor(category).withOpacity(0.10),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color:
                              _categoryColor(category).withOpacity(0.40),
                            ),
                          ),
                          child: Text(
                            "${categoryItems.length}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _categoryColor(category),
                            ),
                          ),
                        ),

                        children: [
                          ...categoryItems.map(
                                (item) =>
                                Card(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 1,
                                  ),
                                  elevation: 0,
                                  color: item.isPurchased
                                      ? Colors.grey.shade100
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: GestureDetector(
                                    onLongPress: () async {
                                      final action = await showModalBottomSheet<
                                          String>(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        builder: (_) {
                                          return SafeArea(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  leading: const Icon(
                                                      Icons.edit),
                                                  title: const Text(
                                                      "Edit Item"),
                                                  onTap: () {
                                                    Navigator.pop(
                                                        context, "edit");
                                                  },
                                                ),
                                                ListTile(
                                                  leading: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  title: const Text(
                                                    "Delete Item",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(
                                                        context, "delete");
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );

                                      if (action == "edit") {
                                        if (!mounted) return;

                                        showDialog(
                                          context: context,
                                          builder: (_) =>
                                              AddShoppingItemDialog(
                                                item: item,
                                              ),
                                        );
                                      }

                                      if (action == "delete") {
                                        if (!mounted) return;

                                        final confirm =
                                        await showDialog<bool>(
                                          context: context,
                                          builder: (_) =>
                                              AlertDialog(
                                                title: const Text(
                                                  "Delete Item",
                                                ),
                                                content: Text(
                                                  "Delete '${item.name}' ?",
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                        context,
                                                        false,
                                                      );
                                                    },
                                                    child: const Text(
                                                      "Cancel",
                                                    ),
                                                  ),
                                                  FilledButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                        context,
                                                        true,
                                                      );
                                                    },
                                                    child: const Text(
                                                      "Delete",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        );

                                        if (confirm == true) {
                                          await ref
                                              .read(
                                            shoppingRepositoryProvider,
                                          )
                                              .deleteItem(item.id!);
                                          await ref
                                              .read(shoppingSyncRepositoryProvider)
                                              .syncPendingItems();
                                        }
                                      }
                                    },
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(14),
                                      onTap: () {
                                        _toggleItem(ref, item);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 14,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item.name,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  decoration: item.isPurchased
                                                      ? TextDecoration.lineThrough
                                                      : null,
                                                  color: item.isPurchased
                                                      ? Colors.grey
                                                      : Colors.black87,
                                                ),
                                              ),
                                            ),

                                            AnimatedSwitcher(
                                              duration: const Duration(milliseconds: 250),
                                              child: item.isPurchased
                                                  ? const Icon(
                                                Icons.check_circle,
                                                key: ValueKey("done"),
                                                color: Colors.green,
                                                size: 24,
                                              )
                                                  : const SizedBox(
                                                key: ValueKey("empty"),
                                                width: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          ).toList(),
                        ],
                            ),
                          ),
                        ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}