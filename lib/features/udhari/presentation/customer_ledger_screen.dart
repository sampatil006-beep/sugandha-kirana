import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/customer_model.dart';
import '../providers/ledger_provider.dart';
import '../data/ledger_filter.dart';
import '../data/customer_ledger_summary.dart';
import 'add_udhari_screen.dart';
import 'add_payment_screen.dart';
import '../widgets/add_entry_sheet.dart';

class CustomerLedgerScreen extends ConsumerWidget {
  final CustomerModel customer;

  const CustomerLedgerScreen({
    super.key,
    required this.customer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ledgerAsync =
    ref.watch(ledgerTimelineProvider(customer.uuid));

    final summaryAsync =
    ref.watch(customerSummaryProvider(customer.uuid));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Ledger"),
      ),
      body: Column(
        children: [
          summaryAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (CustomerLedgerSummary summary) {
              return Card(
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            child: Icon(Icons.person),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  customer.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  customer.mobile?.isNotEmpty == true
                                      ? customer.mobile!
                                      : "Mobile not available",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 28),
                      Row(
                        children: [
                          Expanded(
                            child: _SummaryTile(
                              title: "Outstanding",
                              value:
                              "₹${summary.outstanding.toStringAsFixed(0)}",
                              color: Colors.red,
                            ),
                          ),
                          Expanded(
                            child: _SummaryTile(
                              title: "Udhari",
                              value:
                              "₹${summary.totalCredit.toStringAsFixed(0)}",
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _SummaryTile(
                              title: "Payment",
                              value:
                              "₹${summary.totalPayment.toStringAsFixed(0)}",
                              color: Colors.green,
                            ),
                          ),
                          Expanded(
                            child: _SummaryTile(
                              title: "Entries",
                              value:
                              summary.totalTransactions.toString(),
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Consumer(
              builder: (context, ref, _) {
                final filter = ref.watch(ledgerFilterProvider);

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ChoiceChip(
                        label: const Text("All"),
                        selected: filter == LedgerFilter.all,
                        onSelected: (_) {
                          ref.read(ledgerFilterProvider.notifier).state =
                              LedgerFilter.all;
                        },
                      ),
                      const SizedBox(width: 8),
                      ChoiceChip(
                        label: const Text("Udhari"),
                        selected: filter == LedgerFilter.credit,
                        onSelected: (_) {
                          ref.read(ledgerFilterProvider.notifier).state =
                              LedgerFilter.credit;
                        },
                      ),
                      const SizedBox(width: 8),
                      ChoiceChip(
                        label: const Text("Payment"),
                        selected: filter == LedgerFilter.payment,
                        onSelected: (_) {
                          ref.read(ledgerFilterProvider.notifier).state =
                              LedgerFilter.payment;
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: ledgerAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (e, _) => Center(
                child: Text(e.toString()),
              ),
              data: (entries) {
                final filter = ref.watch(ledgerFilterProvider);

                final filteredEntries = entries.where((timeline) {
                  switch (filter) {
                    case LedgerFilter.all:
                      return true;

                    case LedgerFilter.credit:
                      return timeline.entry.isCredit;

                    case LedgerFilter.payment:
                      return !timeline.entry.isCredit;
                  }
                }).toList();
                if (filteredEntries.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
                          size: 72,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "No Ledger Entries",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Tap + to add first Udhari.",
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    12,
                    0,
                    12,
                    90,
                  ),
                  itemCount: filteredEntries.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final timeline = filteredEntries[index];
                    final entry = timeline.entry;

                    final isCredit = entry.isCredit;

                    return Card(
                      elevation: 1,
                      child: ListTile(
                      onLongPress: () async {
                        final action = await showModalBottomSheet<String>(
                          context: context,
                          showDragHandle: true,
                          builder: (context) {
                            return SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const ListTile(
                                    leading: CircleAvatar(
                                      child: Icon(Icons.receipt_long),
                                    ),
                                    title: Text(
                                      "Ledger Entry",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  const Divider(),

                                  ListTile(
                                    leading: const Icon(Icons.edit),
                                    title: const Text("Edit Entry"),
                                    onTap: () {
                                      Navigator.pop(context, "edit");
                                    },
                                  ),

                                  ListTile(
                                    leading: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    title: const Text("Delete Entry"),
                                    onTap: () {
                                      Navigator.pop(context, "delete");
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );

                        if (action == null) {
                          return;
                        }

                        if (action == "edit") {
                          if (!context.mounted) {
                            return;
                          }

                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                if (entry.isCredit) {
                                  return AddUdhariScreen(
                                    customer: customer,
                                    entry: entry,
                                  );
                                }

                                return AddPaymentScreen(
                                  customer: customer,
                                  entry: entry,
                                );
                              },
                            ),
                          );

                          return;
                        }

                        if (entry.id == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Unable to delete this entry."),
                            ),
                          );
                          return;
                        }

                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text("Delete Entry"),
                              content: const Text(
                                "Are you sure you want to delete this ledger entry?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext, false);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                FilledButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext, true);
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm != true) {
                          return;
                        }

                        await ref.read(ledgerRepositoryProvider).archiveEntry(entry.id!);

                        if (!context.mounted) {
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Ledger entry deleted successfully."),
                          ),
                        );
                      },
                      leading: CircleAvatar(                          backgroundColor: isCredit
                              ? Colors.red.shade50
                              : Colors.green.shade50,
                          child: Icon(
                            isCredit
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: isCredit
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        title: Text(
                          isCredit
                              ? "Udhari"
                              : "Payment",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            if (entry.note != null &&
                                entry.note!.isNotEmpty)
                              Text(entry.note!),
                            const SizedBox(height: 4),
                            Text(
                              entry.entryDate
                                  .toLocal()
                                  .toString()
                                  .substring(0, 16),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "₹${entry.amount.toStringAsFixed(0)}",
                              style: TextStyle(
                                color: isCredit
                                    ? Colors.red
                                    : Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Bal ₹${timeline.runningBalance.toStringAsFixed(0)}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Add Entry"),
        onPressed: () async {
          final type = await showAddEntrySheet(
            context: context,
          );

          if (!context.mounted || type == null) {
            return;
          }

          switch (type) {
            case LedgerEntryType.credit:
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddUdhariScreen(
                    customer: customer,
                  ),
                ),
              );
              break;

            case LedgerEntryType.payment:
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddPaymentScreen(
                    customer: customer,
                  ),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
class _SummaryTile extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _SummaryTile({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color.withOpacity(.08),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}