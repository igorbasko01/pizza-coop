import 'package:pizza_coop/domain/ingredients/ingredient.dart';

class Recipe {
  final String name;
  final List<StockIngredient> ingredients;

  Recipe(this.name, this.ingredients);
}