import 'package:pizza_coop/domain/customer.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/recipe.dart';
import 'package:test/test.dart';

void main() {
  test('Customer is created with a name', () {
    var customer = Customer(1, 'John');
    expect(customer.id, 1);
    expect(customer.name, 'John');
  });

  test('Customer selects a recipe from a menu', () {
    var customer = Customer(1, 'John');
    var menu = Menu(recipes: [
      Recipe('Pizza', [
        StockIngredient('Flour', 1.5),
        StockIngredient('Tomato Sauce', 0.5),
        StockIngredient('Cheese', 2.0),
      ]),
      Recipe('Calzone', [
        StockIngredient('Flour', 1.5),
        StockIngredient('Tomato Sauce', 0.5),
        StockIngredient('Cheese', 2.0),
        StockIngredient('Ham', 1.0),
      ]),
    ]);
    var recipe = customer.selectRecipe(menu);
    expect(recipe, isNotNull);
    expect(recipe.name, 'Pizza');
  });

  test('Customer is created as unsatisfied', () {
    var customer = Customer(1, 'John');
    expect(customer.isSatisfied, false);
  });
}