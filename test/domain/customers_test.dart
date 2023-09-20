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

  test('Customers class should throw exception on duplicate customer ids', () {
    var customers = [
      Customer(1, 'John Doe'),
      Customer(1, 'Jane Doe'),
    ];
    expect(() => Customers(customers), throwsException);
  });

  test('Customers getCustomer should return customer by customer id', () {
    var customers = [
      Customer(1, 'John Doe'),
      Customer(2, 'Jane Doe'),
    ];
    var customersClass = Customers(customers);
    var customer = customersClass.getCustomer(1);
    expect(customer, customers.first);
  });

  test('Customers getCustomer should throw exception on invalid customer id',
      () {
    var customers = [
      Customer(1, 'John Doe'),
      Customer(2, 'Jane Doe'),
    ];
    var customersClass = Customers(customers);
    expect(() => customersClass.getCustomer(3),
        throwsA(isA<CustomersNotFoundException>()));
  });
}
