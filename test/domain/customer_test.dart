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

  test('Customer is satisfied when provided with a StockIngredient that matches the recipe', () {
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
    var stockIngredient = StockIngredient('Pizza', 1);
    customer.selectRecipe(menu);
    customer.accept(stockIngredient);
    expect(customer.isSatisfied, true);
  });

  test('Customer cannot accept a StockIngredient before a recipe is selected', () {
    var customer = Customer(1, 'John');
    var stockIngredient = StockIngredient('Pizza', 1);
    expect(() => customer.accept(stockIngredient), throwsA(isA<NoRecipeSelectedException>()));
  });

  test('Customer should throw an exception if provided with empty menu', () {
    var customer = Customer(1, 'John');
    var menu = Menu(recipes: []);
    expect(() => customer.selectRecipe(menu), throwsA(isA<NoRecipeAvailableException>()));
  });
}