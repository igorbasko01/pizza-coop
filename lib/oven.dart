import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:pizza_coop/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/recipe.dart';

class Oven {
  StockIngredient bake(Recipe recipe, IngredientsStock stock) {
    var pizza = StockIngredient(recipe.name, 1);
    stock.useAll(recipe.ingredients);
    return pizza;
  }
}