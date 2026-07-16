import 'package:flutter/material.dart';

enum CustomerOption {
  ledger,
  edit,
  whatsapp,
  archive,
}

Future<CustomerOption?> showCustomerOptionsSheet({
  required BuildContext context,
  required String customerName,
}) {
  return showModalBottomSheet<CustomerOption>(
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
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(
                  customerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: null,
              ),

              const Divider(),

              ListTile(
                leading: const Icon(Icons.menu_book),
                title: const Text("View Ledger"),
                onTap: () {
                  Navigator.pop(
                    context,
                    CustomerOption.ledger,
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Edit Customer"),
                onTap: () {
                  Navigator.pop(
                    context,
                    CustomerOption.edit,
                  );
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.chat,
                  color: Colors.green,
                ),
                title: const Text("WhatsApp Reminder"),
                onTap: () {
                  Navigator.pop(
                    context,
                    CustomerOption.whatsapp,
                  );
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.archive_outlined,
                  color: Colors.red,
                ),
                title: const Text("Archive Customer"),
                onTap: () {
                  Navigator.pop(
                    context,
                    CustomerOption.archive,
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