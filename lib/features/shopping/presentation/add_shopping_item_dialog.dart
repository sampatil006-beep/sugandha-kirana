import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/shopping_item_model.dart';
import '../providers/shopping_provider.dart';

class AddShoppingItemDialog extends ConsumerStatefulWidget {
  final ShoppingItemModel? item;

  const AddShoppingItemDialog({
    super.key,
    this.item,
  });

  @override
  ConsumerState<AddShoppingItemDialog> createState() =>
      _AddShoppingItemDialogState();
}

class _AddShoppingItemDialogState
    extends ConsumerState<AddShoppingItemDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> _categories = const [
    'Kirana',
    'Cold Drinks',
    'Snacks',
    'General',
    'Other',
  ];

  late String _selectedCategory;

  bool get isEdit => widget.item != null;

  @override
  void initState() {
    super.initState();

    if (isEdit) {
      _controller.text = widget.item!.name;
      _selectedCategory = widget.item!.category;
    } else {
      _selectedCategory = 'Other';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(shoppingRepositoryProvider);

    if (!isEdit) {
      final exists = await repo.itemExists(
        _controller.text.trim(),
      );

      if (exists) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Item already exists."),
          ),
        );
        return;
      }

      await repo.addItem(
        ShoppingItemModel(
          uuid: '',
          name: _controller.text.trim(),
          category: _selectedCategory,
          isPurchased: false,
          isSynced: false,
        ),
      );
      await ref
          .read(shoppingSyncRepositoryProvider)
          .syncPendingItems();
    } else {
      await repo.updateItem(
        widget.item!.copyWith(
          name: _controller.text.trim(),
          category: _selectedCategory,
        ),
      );
      await ref
          .read(shoppingSyncRepositoryProvider)
          .syncPendingItems();
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        isEdit
            ? "Edit Shopping Item"
            : "Add Shopping Item",
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Item Name",
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return "Enter Item Name";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: "Category",
              ),
              items: _categories
                  .map(
                    (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: _save,
          child: Text(
            isEdit ? "Update" : "Save",
          ),
        ),
      ],
    );
  }
}