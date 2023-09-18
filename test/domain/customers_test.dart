import 'package:pizza_coop/domain/customer.dart';
import 'package:pizza_coop/domain/customers.dart';
import 'package:test/test.dart';

void main() {
  test('Customers class initialized with a list of customers', () {
    var customers = [
      Customer(1, 'John Doe'),
      Customer(2, 'Jane Doe'),
    ];
    var customersClass = Customers(customers);
    expect(customersClass.customers, customers);
  });
}