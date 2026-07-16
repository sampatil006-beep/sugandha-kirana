import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/customer_provider.dart';
import '../providers/ledger_provider.dart';
import '../data/customer_dashboard_summary.dart';
import '../widgets/customer_card.dart';
import '../widgets/customer_options_sheet.dart';
import 'add_customer_screen.dart';
import 'customer_ledger_screen.dart';
import '../../../core/services/whatsapp_service.dart';

class CustomerListScreen extends ConsumerStatefulWidget {
  const CustomerListScreen({super.key});

  @override
  ConsumerState<CustomerListScreen> createState() =>
      _CustomerListScreenState();
}

class _CustomerListScreenState
    extends ConsumerState<CustomerListScreen> {
  final TextEditingController _searchController =
  TextEditingController();

  String _search = '';
  final WhatsAppService _whatsAppService =
  const WhatsAppService();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customersProvider);
    final balancesAsync = ref.watch(customerBalancesProvider);

    return customersAsync.when(
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(
          title: const Text("Customers"),
        ),
        body: Center(
          child: Text(e.toString()),
        ),
      ),
      data: (customers) {
        final filteredCustomers = customers.where((customer) {
          if (_search.isEmpty) return true;

          return customer.name.toLowerCase().contains(_search) ||
              (customer.mobile ?? '')
                  .toLowerCase()
                  .contains(_search);
        }).toList();
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddCustomerScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person_add),
            label: const Text("Add Customer"),
          ),
          body: Column(
            children: [
              Consumer(
                builder: (context, ref, _) {
                  final summaryAsync =
                  ref.watch(customerDashboardSummaryProvider);

                  return summaryAsync.when(
                    loading: () => const SizedBox(height: 20),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (CustomerDashboardSummary summary) {
                      return Card(
                        margin: const EdgeInsets.fromLTRB(
                          12,
                          16,
                          12,
                          8,
                        ),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    color: Colors.indigo,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Customer Summary",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: _SummaryItem(
                                      icon: Icons.person,
                                      title: "Customers Due",
                                      value:
                                      summary.customersDue.toString(),
                                      color: Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _SummaryItem(
                                      icon: Icons.currency_rupee,
                                      title: "Outstanding",
                                      value:
                                      "₹${summary.totalOutstanding.toStringAsFixed(0)}",
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  6,
                  16,
                  4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _search = value.trim().toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search customer...",
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _search.isEmpty
                            ? null
                            : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _search = '';
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                        ),
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
                  ],
                ),
              ),
              Expanded(
        child: filteredCustomers.isEmpty
                    ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 72,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "No Customers Yet",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Tap 'Add Customer' to get started.",
                      ),
                    ],
                  ),
                )
        : ListView.builder(
          padding: const EdgeInsets.fromLTRB(
            12,
            0,
            12,
            12,
          ),
          itemCount: filteredCustomers.length,
                  itemBuilder: (context, index) {
        final customer = filteredCustomers[index];

                    return CustomerCard(
                      name: customer.name,
                      mobile: customer.mobile,
                      outstanding: balancesAsync.when(
                        data: (balances) => balances[customer.uuid] ?? 0,
                        loading: () => 0,
                        error: (_, __) => 0,
                      ),
                      overdueDays: 0,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CustomerLedgerScreen(
                              customer: customer,
                            ),
                          ),
                        );
                      },
                      onLedger: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CustomerLedgerScreen(
                              customer: customer,
                            ),
                          ),
                        );
                      },
                      onWhatsApp: () {
                        // TODO
                      },
                      onMore: () async {
                        final option = await showCustomerOptionsSheet(
                          context: context,
                          customerName: customer.name,
                        );

                        if (!context.mounted || option == null) {
                          return;
                        }

                        switch (option) {
                          case CustomerOption.ledger:
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CustomerLedgerScreen(
                                  customer: customer,
                                ),
                              ),
                            );
                            break;

                          case CustomerOption.edit:
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddCustomerScreen(
                                  customer: customer,
                                ),
                              ),
                            );
                            break;

                          case CustomerOption.whatsapp:
                            final outstanding = balancesAsync.when(
                              data: (balances) => balances[customer.uuid] ?? 0,
                              loading: () => 0,
                              error: (_, __) => 0,
                            );

                            if ((customer.mobile ?? '').trim().isEmpty) {
                              if (!context.mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Customer mobile number not available.",
                                  ),
                                ),
                              );
                              break;
                            }

                            if (outstanding <= 0) {
                              if (!context.mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "This customer has no outstanding balance.",
                                  ),
                                ),
                              );
                              break;
                            }

                            final message = '''
नमस्कार ${customer.name} 🙏

आपल्या खात्यामध्ये ₹${outstanding.toStringAsFixed(0)} इतकी उधारी बाकी आहे.

कृपया आपल्या सोयीप्रमाणे लवकरात लवकर पेमेंट करावे.

धन्यवाद 🙏
सुगंधा किराणा स्टोअर
''';

                            await _whatsAppService.openChat(
                              mobile: customer.mobile!,
                              message: message,
                            );

                            break;

                          case CustomerOption.archive:
                            if (customer.id == null) {
                              return;
                            }

                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (dialogContext) {
                                return AlertDialog(
                                  title: const Text("Archive Customer"),
                                  content: Text(
                                    "Archive ${customer.name}?\n\n"
                                        "Customer will be hidden from the active list but can be synced later.",
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
                                      child: const Text("Archive"),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirm != true) {
                              return;
                            }

                            await ref
                                .read(customerRepositoryProvider)
                                .archiveCustomer(customer.id!);

                            if (!context.mounted) {
                              return;
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${customer.name} archived successfully.",
                                ),
                              ),
                            );
                            break;
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _SummaryItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 22,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
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
    );
  }
}