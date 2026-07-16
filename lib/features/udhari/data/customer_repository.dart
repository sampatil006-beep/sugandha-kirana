import 'customer_model.dart';

abstract class CustomerRepository {
  Future<List<CustomerModel>> getAllCustomers();

  Future<CustomerModel?> getCustomerById(int id);

  Future<CustomerModel?> getCustomerByUuid(String uuid);

  Future<void> addCustomer(CustomerModel customer);

  Future<void> updateCustomer(CustomerModel customer);

  Future<void> archiveCustomer(int id);

  Stream<List<CustomerModel>> watchCustomers();

  /// Outstanding balance of one customer.
  Future<double> getOutstandingBalance(
      String customerUuid,
      );

  /// Outstanding balance stream.
  Stream<double> watchOutstandingBalance(
      String customerUuid,
      );
  Future<List<CustomerModel>> getPendingSyncCustomers();

  Future<void> markCustomerSynced(
      String uuid,
      );
  Future<void> markCustomerPending(
      String uuid,
      );
  Future<void> upsertCustomer(
      CustomerModel customer,
      );

}
