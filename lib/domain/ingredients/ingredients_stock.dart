import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/utils/result.dart';

class IngredientsStock {
  final List<StockIngredient> _ingredients = [];

  List<StockIngredient> get ingredients => _ingredients;

  IngredientsStock({List<StockIngredient>? ingredients}) {
    if (ingredients != null) {
      _ingredients.addAll(ingredients);
    }
  }

  void add(StockIngredient ingredient) {
    var existingIngredient = _findFirstIngredient(ingredient.name);
    if (existingIngredient.isSuccess) {
      existingIngredient.value!.add(ingredient.amount);
    } else {
      if (existingIngredient.exception is IngredientNotFoundException) {
        _ingredients.add(ingredient);
      } else {
        throw existingIngredient.exception!;
      }
    }
  }

  void use(StockIngredient ingredient) {
    var existingIngredient = _findFirstIngredient(ingredient.name);
    if (existingIngredient.isSuccess) {
      _subtract(existingIngredient.value!, ingredient);
    } else {
      throw existingIngredient.exception!;
    }
  }

  void useAll(List<StockIngredient> ingredients) {
    var result = _isEnoughIngredients(ingredients);
    if (result.isSuccess) {
      ingredients.forEach(use);
    } else {
      throw result.exception!;
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

  Result<void> _isEnoughIngredients(List<StockIngredient> ingredients) {
    for (var ingredient in ingredients) {
      var existingIngredient = _findFirstIngredient(ingredient.name);
      if (existingIngredient.isFailure) {
        return Result.failure(existingIngredient.exception!);
      }

      var isEnough = existingIngredient.value!.amount >= ingredient.amount;
      if (!isEnough) {
        return Result.failure(InsufficientIngredientException(
            "Insufficient ingredient, needed: ${ingredient.amount}, available: ${existingIngredient.value!.amount}"));
      }
    }
    return Result.success(null);
  }

  Result<StockIngredient> _findFirstIngredient(String name) {
    try {
      var ingredient = _ingredients
          .firstWhere((existingIngredient) => existingIngredient.name == name);
      return Result.success(ingredient);
    } on StateError {
      return Result.failure(
          IngredientNotFoundException("Ingredient $name not found in stock"));
    }
  }
}
