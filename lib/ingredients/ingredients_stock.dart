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
      _subtract(existingIngredient, ingredient);
    } else {
      throw IngredientNotFoundException("Ingredient ${ingredient.name} not found");
    }
  }

  void useAll(List<StockIngredient> ingredients) {
    if (_isEnoughIngredients(ingredients)) {
      ingredients.forEach(use);
    } else {
      throw InsufficientIngredientException("Insufficient ingredients");
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
      if (existingIngredient == null) {
        throw IngredientNotFoundException("Ingredient ${ingredient.name} not found");
      }
      return existingIngredient.amount >= ingredient.amount;
    });
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