import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/oven.dart';
import 'package:pizza_coop/domain/recipe.dart';

class CookRole {
  final Oven oven;
  final IngredientsStock ingredientsStock;
  final PreparedIngredients preparedIngredients;

  CookRole(this.oven, this.ingredientsStock, this.preparedIngredients);

  void bake(Recipe recipe) {
    var result = oven.bake(recipe, ingredientsStock);
    if (result.isSuccess) {
      preparedIngredients.add(result.value!);
    } else {
      throw result.exception!;
    }
  }
}