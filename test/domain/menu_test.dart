import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/recipe.dart';
import 'package:test/test.dart';

void main() {
  test('Menu should be initialized with recipes', () {
    var recipes = [
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
    ];
    var menu = Menu(recipes: recipes);
    expect(menu.recipes, isNotEmpty);
  });
}