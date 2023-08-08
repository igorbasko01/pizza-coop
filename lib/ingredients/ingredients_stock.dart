import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:pizza_coop/ingredients/ingredients_catalog.dart';

class IngredientsStock {
  final List<StockIngredient> _ingredients = [];

  List<StockIngredient> get ingredients => _ingredients;

  void add(StockIngredient ingredient) {
    var existingIngredient = _findFirstIngredient(ingredient.name);
    if (existingIngredient != null) {
      existingIngredient.add(ingredient.amount);
    } else {
      _ingredients.add(ingredient);
    }
  }

  void use(StockIngredient ingredient) {
    var existingIngredient = _findFirstIngredient(ingredient.name);
    if (existingIngredient != null) {
      existingIngredient.subtract(ingredient.amount);
    } else {
      throw IngredientNotFoundException("Ingredient ${ingredient.name} not found");
    }
  }

  StockIngredient? _findFirstIngredient(String name) {
    try {
      return _ingredients.firstWhere(
              (existingIngredient) => existingIngredient.name == name,
          orElse: () => throw IngredientNotFoundException("Ingredient $name not found"));
    } on IngredientNotFoundException {
      return null;
    }
  }
}