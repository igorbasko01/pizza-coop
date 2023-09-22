import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/oven.dart';
import 'package:pizza_coop/domain/recipe.dart';

class CookRole {
  final Oven oven;
  final IngredientsStock ingredientsStock;
  final List<StockIngredient> preparedIngredients;

  CookRole(this.oven, this.ingredientsStock, this.preparedIngredients);

  StockIngredient bake(Recipe recipe) {
    return oven.bake(recipe, ingredientsStock);
  }
}