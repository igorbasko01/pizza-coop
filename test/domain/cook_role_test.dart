import 'package:pizza_coop/domain/cook_role.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/oven.dart';
import 'package:pizza_coop/domain/recipe.dart';
import 'package:test/test.dart';

void main() {
  test('Cook Role Initializes with an Oven', () {
    var oven = Oven();
    var ingredientsStock = IngredientsStock();
    var preparedIngredients = PreparedIngredients();
    var role = CookRole(oven, ingredientsStock, preparedIngredients);
    expect(role.oven, isNotNull);
  });

  test('Cook Role Initializes with an IngredientsStock', () {
    var oven = Oven();
    var ingredientsStock = IngredientsStock();
    var preparedIngredients = PreparedIngredients();
    var role = CookRole(oven, ingredientsStock, preparedIngredients);
    expect(role.ingredientsStock, isNotNull);
  });

  test('Cook Role bakes pizza', () {
    var oven = Oven();
    var ingredientsStock = IngredientsStock(ingredients: [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
    var margheritaRecipe = Recipe('Margherita', [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
    var preparedIngredients = PreparedIngredients();
    var role = CookRole(oven, ingredientsStock, preparedIngredients);
    role.bake(margheritaRecipe);
    expect(role.preparedIngredients.ingredients[0].name, 'Margherita');
  });

  test('Cook Role successful bake remove stock ingredients', () {
    var oven = Oven();
    var ingredientsStock = IngredientsStock(ingredients: [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
    var margheritaRecipe = Recipe('Margherita', [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
    var preparedIngredients = PreparedIngredients();
    var role = CookRole(oven, ingredientsStock, preparedIngredients);
    role.bake(margheritaRecipe);
    expect(ingredientsStock.ingredients, isEmpty);
  });

  test('Cook Role unsuccessful bake does not remove stock ingredients', () {
    var oven = Oven();
    var ingredientsStock = IngredientsStock(ingredients: [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
    var margheritaRecipe = Recipe('Margherita', [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
      StockIngredient('Pepperoni', 1.0),
    ]);
    var preparedIngredients = PreparedIngredients();
    var role = CookRole(oven, ingredientsStock, preparedIngredients);
    expect(() => role.bake(margheritaRecipe),
        throwsA(isA<IngredientNotFoundException>()));
    expect(ingredientsStock.ingredients, isNotEmpty);
    expect(ingredientsStock.ingredients.length, 3);
    expect(ingredientsStock.ingredients, [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
  });

  test('Cook Role bake throws exception if there is insufficient ingredient',
      () {
    var oven = Oven();
    var ingredientsStock = IngredientsStock(ingredients: [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
    var margheritaRecipe = Recipe('Margherita', [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 3.0),
    ]);
    var preparedIngredients = PreparedIngredients();
    var role = CookRole(oven, ingredientsStock, preparedIngredients);
    expect(() => role.bake(margheritaRecipe),
        throwsA(isA<InsufficientIngredientException>()));
  });

  test(
      'Cook role doesnt remove any ingredients if one ingredient is insufficient',
      () {
    var oven = Oven();
    var ingredientsStock = IngredientsStock(ingredients: [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
    var margheritaRecipe = Recipe('Margherita', [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 3.0),
    ]);
    var preparedIngredients = PreparedIngredients();
    var role = CookRole(oven, ingredientsStock, preparedIngredients);
    expect(() => role.bake(margheritaRecipe),
        throwsA(isA<InsufficientIngredientException>()));
    expect(ingredientsStock.ingredients, isNotEmpty);
    expect(ingredientsStock.ingredients.length, 3);
    expect(ingredientsStock.ingredients, [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
  });

  test('Cook Role holds a PreparedIngredients for prepared ingredients', () {
    var oven = Oven();
    var ingredientsStock = IngredientsStock();
    var preparedIngredients = PreparedIngredients();
    var role = CookRole(oven, ingredientsStock, preparedIngredients);
    expect(role.preparedIngredients, isNotNull);
    expect(role.preparedIngredients.ingredients, isEmpty);
  });

  test('Cook Role adds the prepared ingredient to the PreparedIngredients', () {
    var oven = Oven();
    var ingredientsStock = IngredientsStock(ingredients: [
      StockIngredient('Flour', 3),
      StockIngredient('Tomato Sauce', 3),
      StockIngredient('Cheese', 3),
    ]);
    var preparedIngredients = PreparedIngredients();
    var recipe = Recipe('Margherita', [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 1),
      StockIngredient('Cheese', 2.0),
    ]);
    var role = CookRole(oven, ingredientsStock, preparedIngredients);
    role.bake(recipe);
    expect(role.preparedIngredients.ingredients, isNotEmpty);
    expect(role.preparedIngredients.ingredients.length, 1);
    expect(role.preparedIngredients.ingredients[0].name, 'Margherita');
    expect(role.preparedIngredients.ingredients[0].amount, 1);
  });
}
