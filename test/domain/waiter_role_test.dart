import 'package:pizza_coop/domain/customer.dart';
import 'package:pizza_coop/domain/waiter_role.dart';
import 'package:test/test.dart';

void main() {
  test('Waiter Role initialized with a list of customers', () {
    var customers = [
      Customer('John Doe'),
      Customer('Jane Doe'),
    ];
    var waiter = WaiterRole(customers);
    expect(waiter.customers, customers);
  });
}