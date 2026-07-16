import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/providers/product_provider.dart';

import '../data/customer_model.dart';
import '../data/customer_repository.dart';
import '../data/local_customer_repository.dart';
import '../data/customer_sync_repository.dart';
final customerRepositoryProvider =
Provider<CustomerRepository>((ref) {
  return LocalCustomerRepository(
    ref.read(appDatabaseProvider),
  );
});

/// Realtime Customers
final customersProvider =
StreamProvider.autoDispose<List<CustomerModel>>((ref) {
  return ref
      .read(customerRepositoryProvider)
      .watchCustomers();
});

final customerOutstandingProvider =
StreamProvider.autoDispose.family<double, String>(
      (ref, customerUuid) {
    return ref
        .read(customerRepositoryProvider)
        .watchOutstandingBalance(customerUuid);
  },
);
final customerSyncRepositoryProvider =
Provider<CustomerSyncRepository>((ref) {
  return CustomerSyncRepository(
    ref.read(appDatabaseProvider),
  );
});