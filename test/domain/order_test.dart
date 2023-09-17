import 'package:pizza_coop/domain/customer.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/order.dart';
import 'package:pizza_coop/domain/recipe.dart';
import 'package:test/test.dart';

void main() {
  test('Order initialized with Recipe and a Customer', () {
    var recipe = Recipe('Pizza', [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
    var customer = Customer(1, 'John Doe');
    var order = Order(recipe, customer);
    expect(order.recipe, recipe);
    expect(order.customer, customer);
  });
}