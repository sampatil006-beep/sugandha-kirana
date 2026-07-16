import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/customer_model.dart';
import '../data/ledger_model.dart';
import '../providers/ledger_provider.dart';

class AddPaymentScreen extends ConsumerStatefulWidget {
  final CustomerModel customer;
  final LedgerModel? entry;

  const AddPaymentScreen({
    super.key,
    required this.customer,
    this.entry,
  });

  @override
  ConsumerState<AddPaymentScreen> createState() =>
      _AddPaymentScreenState();
}

class _AddPaymentScreenState
    extends ConsumerState<AddPaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _amountController =
  TextEditingController();

  final _noteController =
  TextEditingController();

  DateTime _entryDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.entry != null) {
      _amountController.text =
          widget.entry!.amount.toStringAsFixed(0);

      _noteController.text =
          widget.entry!.note ?? "";

      _entryDate = widget.entry!.entryDate;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _entryDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (selected == null) return;

    setState(() {
      _entryDate = selected;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final repo = ref.read(
      ledgerRepositoryProvider,
    );

    final entry = widget.entry == null
        ? LedgerModel(
      uuid: '',
      customerUuid: widget.customer.uuid,
      type: 'payment',
      amount: double.parse(
        _amountController.text.trim(),
      ),
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      entryDate: _entryDate,
      isSynced: false,
    )
        : widget.entry!.copyWith(
      amount: double.parse(
        _amountController.text.trim(),
      ),
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      entryDate: _entryDate,
      isSynced: false,
      updatedAt: DateTime.now(),
    );

    await repo.insertOrUpdateEntry(entry);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.entry == null
              ? "Payment added successfully."
              : "Payment updated successfully.",
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
          widget.entry == null
              ? "Add Payment"
              : "Edit Payment",
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE8F5E9),
                  child: Icon(
                    Icons.currency_rupee,
                    color: Colors.green,
                  ),
                ),
                title: Text(widget.customer.name),
                subtitle: Text(
                  widget.customer.mobile ??
                      "Mobile not available",
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _amountController,
              keyboardType:
              const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: "Payment Amount",
                prefixText: "₹ ",
                prefixIcon:
                Icon(Icons.currency_rupee),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return "Enter payment amount";
                }

                final amount =
                double.tryParse(value);

                if (amount == null ||
                    amount <= 0) {
                  return "Enter valid amount";
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _noteController,
              maxLines: 3,
              decoration:
              const InputDecoration(
                labelText: "Note",
                prefixIcon:
                Icon(Icons.notes),
              ),
            ),

            const SizedBox(height: 16),

            ListTile(
              contentPadding:
              EdgeInsets.zero,
              leading: const Icon(
                Icons.calendar_today,
              ),
              title: const Text(
                "Payment Date",
              ),
              subtitle: Text(
                "${_entryDate.day}/${_entryDate.month}/${_entryDate.year}",
              ),
              trailing: FilledButton(
                onPressed: _pickDate,
                child: const Text("Change"),
              ),
            ),

            const SizedBox(height: 30),

            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: const Text(
                "Save Payment",
              ),
            ),
          ],
        ),
      ),
    );
  }
}