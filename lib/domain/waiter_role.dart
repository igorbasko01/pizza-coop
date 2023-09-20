import 'package:pizza_coop/domain/customers.dart';
import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/order.dart';

class WaiterRole {
  final Menu menu;
  Customers customers;

  WaiterRole(this.menu, this.customers);

  Order takeOrder(int customerId) {
    var customer = customers.getCustomer(customerId);
    var recipe = customer.selectRecipe(menu);
    return Order(recipe, customer);
  }
}