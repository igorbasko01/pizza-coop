import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/recipe.dart';
import 'package:pizza_coop/utils/result.dart';

class Oven {
  Result<StockIngredient> bake(Recipe recipe, IngredientsStock stock) {
    var pizza = StockIngredient(recipe.name, 1);
    var result = stock.useAll(recipe.ingredients);
    if (result.isSuccess) {
      return Result.success(pizza);
    } else {
      return Result.failure(result.exception!);
    }
  }
}