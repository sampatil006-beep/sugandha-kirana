import 'package:drift/drift.dart' as drift;
import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/customers_table.dart';

part 'customer_dao.g.dart';

@DriftAccessor(tables: [Customers])
class CustomerDao extends DatabaseAccessor<AppDatabase>
    with _$CustomerDaoMixin {
  CustomerDao(super.db);

  Future<List<Customer>> getAllCustomers() {
    return (select(customers)
      ..where((tbl) => tbl.deletedAt.isNull())
      ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.name),
      ]))
        .get();
  }

  Stream<List<Customer>> watchCustomers() {
    return (select(customers)
      ..where((tbl) => tbl.deletedAt.isNull())
      ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.name),
      ]))
        .watch();
  }

  Future<Customer?> getCustomerById(int id) {
    return (select(customers)
      ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<Customer?> getCustomerByUuid(String uuid) {
    return (select(customers)
      ..where((tbl) => tbl.uuid.equals(uuid)))
        .getSingleOrNull();
  }

  Future<int> insertCustomer(
      CustomersCompanion customer,
      ) {
    return into(customers).insert(customer);
  }

  Future<void> insertOrUpdateCustomer(
      CustomersCompanion customer,
      ) async {
    final uuid = customer.uuid.value;

    final existing = await (select(customers)
      ..where((t) => t.uuid.equals(uuid)))
        .getSingleOrNull();

    if (existing == null) {
      await into(customers).insert(customer);
    } else {
      await (update(customers)
        ..where((t) => t.uuid.equals(uuid)))
          .write(customer);
    }
  }

  Future<bool> updateCustomer(
      Customer customer,
      ) {
    return update(customers).replace(customer);
  }

  Future<void> archiveCustomer(int id) async {
    await (update(customers)
      ..where((tbl) => tbl.id.equals(id)))
        .write(
      CustomersCompanion(
        deletedAt: drift.Value(DateTime.now()),
        isSynced: const drift.Value(false),
      ),
    );
  }

  Future<List<Customer>> getPendingSyncCustomers() {
    return (select(customers)
      ..where((tbl) => tbl.isSynced.equals(false)))
        .get();
  }

  Future<void> markCustomerSynced(String uuid) {
    return (update(customers)
      ..where((tbl) => tbl.uuid.equals(uuid)))
        .write(
      const CustomersCompanion(
        isSynced: Value(true),
      ),
    );
  }

  Future<void> markCustomerPending(String uuid) {
    return (update(customers)
      ..where((tbl) => tbl.uuid.equals(uuid)))
        .write(
      const CustomersCompanion(
        isSynced: Value(false),
      ),
    );
  }

  Future<void> deleteByUuid(String uuid) async {
    await (delete(customers)
      ..where((tbl) => tbl.uuid.equals(uuid)))
        .go();
  }
}