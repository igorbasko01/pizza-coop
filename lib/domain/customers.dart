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