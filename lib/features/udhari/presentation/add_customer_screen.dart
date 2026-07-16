import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/customer_model.dart';
import '../providers/customer_provider.dart';

class AddCustomerScreen extends ConsumerStatefulWidget {
  final CustomerModel? customer;

  const AddCustomerScreen({
    super.key,
    this.customer,
  });

  @override
  ConsumerState<AddCustomerScreen> createState() =>
      _AddCustomerScreenState();
}

class _AddCustomerScreenState
    extends ConsumerState<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _mobileController;
  late final TextEditingController _addressController;

  bool get isEdit => widget.customer != null;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(
      text: widget.customer?.name ?? '',
    );

    _mobileController = TextEditingController(
      text: widget.customer?.mobile ?? '',
    );

    _addressController = TextEditingController(
      text: widget.customer?.address ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    super.dispose();
  }
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final repo = ref.read(customerRepositoryProvider);

    final customer = CustomerModel(
      id: widget.customer?.id,
      uuid: widget.customer?.uuid ?? '',
      name: _nameController.text.trim(),
      mobile: _mobileController.text.trim().isEmpty
          ? null
          : _mobileController.text.trim(),
      address: _addressController.text.trim().isEmpty
          ? null
          : _addressController.text.trim(),
      isSynced: false,
      deletedAt: widget.customer?.deletedAt,
      lastReminderSentAt:
      widget.customer?.lastReminderSentAt,
      createdAt: widget.customer?.createdAt,
      updatedAt: DateTime.now(),
    );

    if (isEdit) {
      await repo.updateCustomer(customer);
    } else {
      await repo.addCustomer(customer);
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEdit
              ? "Customer updated successfully"
              : "Customer added successfully",
        ),
      ),
    );

    Navigator.pop(context, true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit
              ? "Edit Customer"
              : "Add Customer",
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "Customer Name",
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return "Customer name is required";
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _mobileController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Mobile Number",
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _addressController,
              textInputAction: TextInputAction.done,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Address",
                prefixIcon: Icon(Icons.location_on),
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 28),

            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: Text(
                isEdit
                    ? "Update Customer"
                    : "Save Customer",
              ),
            ),
          ],
        ),
      ),
    );
  }
}