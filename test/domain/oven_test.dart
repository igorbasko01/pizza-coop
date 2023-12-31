import 'package:flutter_test/flutter_test.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/oven.dart';
import 'package:pizza_coop/domain/recipe.dart';

void main() {
  test('Oven receives a recipe and ingredients stock and returns a pizza ingredient', () {
    var oven = Oven();
    var recipe = Recipe('Pizza', [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    stock.add(StockIngredient('Tomato Sauce', 0.5));
    stock.add(StockIngredient('Cheese', 2.0));
    var result = oven.bake(recipe, stock);
    expect(result.isSuccess, true);
    expect(result.value!.name, 'Pizza');
    expect(result.value!.amount, 1);
  });

  test('Oven returns an exception when not enough ingredients', () {
    var oven = Oven();
    var recipe = Recipe('Pizza', [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    stock.add(StockIngredient('Tomato Sauce', 0.5));
    stock.add(StockIngredient('Cheese', 1.0));
    expect(oven.bake(recipe, stock).exception, isA<InsufficientIngredientException>());
  });

  test('Oven returns an exception when ingredient is not found in stock', () {
    var oven = Oven();
    var recipe = Recipe('Pizza', [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    stock.add(StockIngredient('Tomato Sauce', 0.5));
    expect(oven.bake(recipe, stock).exception, isA<IngredientNotFoundException>());
  });

  test('Oven bake removes ingredients from stock', () {
    var oven = Oven();
    var recipe = Recipe('Pizza', [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 1.0),
    ]);
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    stock.add(StockIngredient('Tomato Sauce', 0.5));
    stock.add(StockIngredient('Cheese', 2.0));
    oven.bake(recipe, stock);
    expect(stock.ingredients, isNotEmpty);
    expect(stock.ingredients.length, 1);
    expect(stock.ingredients[0].name, 'Cheese');
    expect(stock.ingredients[0].amount, 1.0);
  });
}