import 'package:pizza_coop/domain/customers.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/order.dart';

class WaiterRole {
  final Menu menu;
  final Customers customers;
  final PreparedIngredients preparedIngredients;

  WaiterRole(this.menu, this.customers, this.preparedIngredients);

  Order takeOrder(int customerId) {
    var customer = customers.getCustomer(customerId);
    var recipe = customer.selectRecipe(menu);
    return Order(recipe, customer);
  }
}