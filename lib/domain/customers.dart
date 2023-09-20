import 'package:pizza_coop/domain/customer.dart';

class Customers {
  List<Customer> customers;

  Customers(this.customers) {
    var validation = validateCustomers();
    if (!validation.success) {
      customers = [];
      throw CustomersValidationException(validation.message);
    }
  }

  CustomersValidationResult validateCustomers() {
    // Return false on duplicate customer ids
    var ids = customers.map((e) => e.id).toSet();
    if (ids.length != customers.length) {
      return CustomersValidationResult(false, 'Duplicate customer ids');
    }
    return CustomersValidationResult(true, '');
  }

  /// Get customer by customer id
  ///
  /// Throws CustomersNotFoundException if customer id is not found
  Customer getCustomer(int customerId) {
    var customer = customers.firstWhere((e) => e.id == customerId,
        orElse: () =>
            throw CustomersNotFoundException(customerId));
    return customer;
  }
}

class CustomersValidationResult {
  final bool success;
  final String message;

  CustomersValidationResult(this.success, this.message);
}

class CustomersValidationException implements Exception {
  final String message;

  CustomersValidationException(this.message);
}

class CustomersNotFoundException implements Exception {
  final int customerId;

  CustomersNotFoundException(this.customerId);

  @override
  String toString() {
    return 'Customer not found: $customerId';
  }
}
