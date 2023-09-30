import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/recipe.dart';
import 'package:pizza_coop/utils/result.dart';

class Customer {
  final int id;
  String name;
  bool _isSatisfied = false;
  Recipe? _selectedRecipe;

  Customer(this.id, this.name);

  Recipe selectRecipe(Menu menu) {
    if (menu.recipes.isEmpty) {
      throw NoRecipeAvailableException('Menu has no recipes');
    }
    _selectedRecipe ??= menu.recipes.first;
    return _selectedRecipe!;
  }

  bool get isSatisfied => _isSatisfied;

  Result<void> accept(StockIngredient stockIngredient) {
    var expectedAmount = 1;
    if (_selectedRecipe == null) {
      return Result.failure(NoRecipeSelectedException(
          'Customer has not selected a recipe yet, nothing to accept'));
    }
    if (stockIngredient.name != _selectedRecipe?.name) {
      return Result.failure(UnwantedIngredientException(
          'Customer does not want ${stockIngredient.name}'));
    }
    if (stockIngredient.amount < 1) {
      return Result.failure(NotEnoughIngredientsException(
          'Customer wants at least $expectedAmount ${stockIngredient.name}'));
    }
    _isSatisfied = true;
    return Result.success(null);
  }
}

class NoRecipeSelectedException implements Exception {
  final String message;

  NoRecipeSelectedException(this.message);
}

class NoRecipeAvailableException implements Exception {
  final String message;

  NoRecipeAvailableException(this.message);
}

class UnwantedIngredientException implements Exception {
  final String message;

  UnwantedIngredientException(this.message);
}

class NotEnoughIngredientsException implements Exception {
  final String message;

  NotEnoughIngredientsException(this.message);
}
