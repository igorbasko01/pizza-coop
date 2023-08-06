import 'package:pizza_coop/ingredients/ingredient.dart';

class IngredientsCatalog {
  List<PurchasableIngredient> _ingredients = [];

  List<PurchasableIngredient> get ingredients => _ingredients;

  IngredientsCatalog({List<PurchasableIngredient>? ingredients}) {
    if (ingredients != null) {
      _ingredients = ingredients;
    }
  }
}