import 'package:pizza_coop/domain/customer.dart';
import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/order.dart';
import 'package:pizza_coop/domain/recipe.dart';

class WaiterRole {
  final Menu menu;
  List<Customer> customers;

  WaiterRole(this.menu, this.customers);

  Order takeOrder(int customerId) {
    var customer = customers.firstWhere((c) => c.id == customerId);
    var recipe = customer.selectRecipe(menu);
    return Order(recipe, customer);
  }
}