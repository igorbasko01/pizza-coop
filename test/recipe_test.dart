import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:pizza_coop/recipe.dart';
import 'package:test/test.dart';

void main() {
  test('Recipe initializes with stock ingredients and a name', () {
    var recipe = Recipe('Pizza', [
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 2.0),
    ]);
    expect(recipe.name, 'Pizza');
    expect(recipe.ingredients, isNotEmpty);
    expect(recipe.ingredients.length, 3);
  });
}