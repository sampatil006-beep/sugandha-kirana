import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../calculator/presentation/calculator_screen.dart';
import '../../products/presentation/product_list_screen.dart';
import '../../shopping/presentation/shopping_list_screen.dart';
import '../../udhari/presentation/customer_list_screen.dart';
import '../../products/providers/product_provider.dart';
import '../../products/data/product_sync_repository.dart';
import '../../shopping/data/shopping_sync_repository.dart';
import '../../shopping/providers/shopping_provider.dart';
import '../../udhari/providers/customer_provider.dart';
import '../../udhari/providers/ledger_provider.dart';
import '../../../core/supabase/realtime_service.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int index = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(productSyncRepositoryProvider)
          .syncPendingProducts();

      await ref
          .read(productSyncRepositoryProvider)
          .downloadProducts();

      await ref
          .read(shoppingSyncRepositoryProvider)
          .syncPendingItems();

      await ref
          .read(shoppingSyncRepositoryProvider)
          .downloadItems();

      await ref
          .read(customerSyncRepositoryProvider)
          .syncPendingCustomers();

      await ref
          .read(customerSyncRepositoryProvider)
          .downloadCustomers();

      await ref
          .read(ledgerSyncRepositoryProvider)
          .syncPendingEntries();

      await ref
          .read(ledgerSyncRepositoryProvider)
          .downloadEntries();

      RealtimeService.instance.start(
        onCustomersChanged: () async {
          await ref
              .read(customerSyncRepositoryProvider)
              .downloadCustomers();
        },
        onLedgerChanged: () async {
          await ref
              .read(ledgerSyncRepositoryProvider)
              .downloadEntries();
        },
      );
    });
  }

  final List<Widget> pages = const [
    ProductListScreen(),
    CalculatorScreen(),
    ShoppingListScreen(),
    CustomerListScreen(),
  ];

  @override
  void dispose() {
    RealtimeService.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.inventory_2),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Shopping',
          ),
          NavigationDestination(
            icon: Icon(Icons.people),
            label: 'Udhari',
          ),
        ],
      ),
    );
  }
}