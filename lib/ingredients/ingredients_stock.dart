import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:pizza_coop/ingredients/ingredients_catalog.dart';

class IngredientsStock {
  final List<StockIngredient> _ingredients = [];

  List<StockIngredient> get ingredients => _ingredients;

  void add(StockIngredient ingredient) {
    try {
      var existingIngredient = _findFirstIngredient(ingredient.name);
      existingIngredient.add(ingredient.amount);
    } on IngredientNotFoundException {
      _ingredients.add(ingredient);
      return;
    }
  }

  void use(StockIngredient ingredient) {
    var existingIngredient = _findFirstIngredient(ingredient.name);
    _subtract(existingIngredient, ingredient);
  }

  void useAll(List<StockIngredient> ingredients) {
    if (_isEnoughIngredients(ingredients)) {
      ingredients.forEach(use);
    }
  }

  void _subtract(StockIngredient left, StockIngredient right) {
    if (left.name != right.name) {
      throw ArgumentError("Cannot subtract different ingredients");
    }
    left.subtract(right.amount);
    if (left.amount == 0) {
      _ingredients.remove(left);
    }
  }

  bool _isEnoughIngredients(List<StockIngredient> ingredients) {
    return ingredients.every((ingredient) {
      var existingIngredient = _findFirstIngredient(ingredient.name);
      var isEnough = existingIngredient.amount >= ingredient.amount;
      if (!isEnough) {
        throw InsufficientIngredientException(
            "Insufficient ingredient, needed: ${ingredient.amount}, available: ${existingIngredient.amount}");
      }
      return isEnough;
    });
  }

  StockIngredient _findFirstIngredient(String name) {
    return _ingredients.firstWhere(
        (existingIngredient) => existingIngredient.name == name,
        orElse: () =>
            throw IngredientNotFoundException("Ingredient $name not found"));
  }
}
