import '../../../core/sync/sync_entity.dart';
import '../../../core/sync/sync_repository.dart';
import '../data/customer_model.dart';
import '../data/customer_repository.dart';

class CustomerSyncRepository
    extends SyncRepository<CustomerModel> {
  final CustomerRepository repository;

  CustomerSyncRepository({
    required this.repository,
  });

  @override
  Future<List<CustomerModel>> getPendingSyncItems() {
    return repository.getPendingSyncCustomers();
  }

  @override
  Future<void> markAsFailed(String uuid) async {
    // TODO
  }

  @override
  Future<void> markAsSynced(String uuid) {
    return repository.markCustomerSynced(uuid);
  }

  @override
  Future<void> upload(CustomerModel item) async {
    // TODO
  }

  @override
  Future<void> download({
    DateTime? lastSyncedAt,
  }) async {
    // TODO
  }
}