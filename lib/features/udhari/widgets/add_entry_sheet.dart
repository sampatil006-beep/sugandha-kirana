import 'package:flutter/material.dart';

enum LedgerEntryType {
  credit,
  payment,
}

Future<LedgerEntryType?> showAddEntrySheet({
  required BuildContext context,
}) {
  return showModalBottomSheet<LedgerEntryType>(
    context: context,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.receipt_long),
                ),
                title: Text(
                  "Add Ledger Entry",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Select entry type",
                ),
              ),

              const Divider(),

              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFFFEBEE),
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.red,
                  ),
                ),
                title: const Text("Add Udhari"),
                subtitle: const Text(
                  "Increase customer's outstanding balance",
                ),
                onTap: () {
                  Navigator.pop(
                    context,
                    LedgerEntryType.credit,
                  );
                },
              ),

              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE8F5E9),
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.green,
                  ),
                ),
                title: const Text("Add Payment"),
                subtitle: const Text(
                  "Record payment received",
                ),
                onTap: () {
                  Navigator.pop(
                    context,
                    LedgerEntryType.payment,
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}