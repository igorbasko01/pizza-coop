import 'package:pizza_coop/domain/customer.dart';
import 'package:pizza_coop/domain/customers.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/order.dart';
import 'package:pizza_coop/domain/recipe.dart';
import 'package:pizza_coop/domain/waiter_role.dart';
import 'package:test/test.dart';

void main() {
  test('Waiter Role initialized with a list of customers', () {
    var customers = Customers([
      Customer(1, 'John Doe'),
      Customer(2, 'Jane Doe'),
    ]);
    var menu = Menu(recipes: [
      Recipe('Pizza', [
        StockIngredient('Flour', 1.5),
        StockIngredient('Tomato Sauce', 0.5),
        StockIngredient('Cheese', 2.0),
      ]),
      Recipe('Pasta', [
        StockIngredient('Flour', 1.0),
        StockIngredient('Tomato Sauce', 0.5),
      ]),
    ]);
    var waiter = WaiterRole(menu, customers);
    expect(waiter.customers, customers);
  });

  test('Waiter Role takes an order from customer specific customer', () {
    var customers = Customers([
      Customer(1, 'John Doe'),
      Customer(2, 'Jane Doe'),
    ]);
    var menu = Menu(recipes: [
      Recipe('Pizza', [
        StockIngredient('Flour', 1.5),
        StockIngredient('Tomato Sauce', 0.5),
        StockIngredient('Cheese', 2.0),
      ]),
      Recipe('Pasta', [
        StockIngredient('Flour', 1.0),
        StockIngredient('Tomato Sauce', 0.5),
      ]),
    ]);
    var waiter = WaiterRole(menu, customers);
    var customer = customers.getCustomer(1);
    var order = waiter.takeOrder(customer.id);
    var expectedOrder = Order(menu.recipes.first, customer);
    expect(order, expectedOrder);
  });
}
