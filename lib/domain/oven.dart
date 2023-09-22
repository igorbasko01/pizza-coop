import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/recipe.dart';

class Oven {
  StockIngredient bake(Recipe recipe, IngredientsStock stock) {
    var pizza = StockIngredient(recipe.name, 1);
    var result = stock.useAll(recipe.ingredients);
    if (result.isFailure) {
      throw result.exception!;
    }
    return pizza;
  }
}