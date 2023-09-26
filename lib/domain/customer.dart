import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/recipe.dart';

class Customer {
  final int id;
  String name;
  bool _isSatisfied = false;
  Recipe? _selectedRecipe;

  Customer(this.id, this.name);

  Recipe selectRecipe(Menu menu) {
    _selectedRecipe ??= menu.recipes.first;
    return _selectedRecipe!;
  }

  bool get isSatisfied => _isSatisfied;

  void accept(StockIngredient stockIngredient) {
    if (_selectedRecipe == null) throw NoRecipeSelectedException('No recipe selected');
    if (stockIngredient.name == _selectedRecipe?.name) _isSatisfied = true;
  }
}

class NoRecipeSelectedException implements Exception {
  final String message;

  NoRecipeSelectedException(this.message);
}