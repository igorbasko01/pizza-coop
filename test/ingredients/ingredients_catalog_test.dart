import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:pizza_coop/ingredients/ingredients_catalog.dart';
import 'package:test/test.dart';

void main() {
  test('IngredientsCatalog initial ingredients are empty', () {
    var catalog = IngredientsCatalog();
    expect(catalog.ingredients, isEmpty);
  });

  test('IngredientsCatalog can be initialized with a list of PurchasableIngredients', () {
    var catalog = IngredientsCatalog(ingredients: [
      PurchasableIngredient('Flour', 1.5),
      PurchasableIngredient('Tomato Sauce', 0.5),
      PurchasableIngredient('Cheese', 2.0),
    ]);
    expect(catalog.ingredients, isNotEmpty);
    expect(catalog.ingredients.length, 3);
  });

  test('IngredientsCatalog is empty if initialized with a null', () {
    var catalog = IngredientsCatalog(ingredients: null);
    expect(catalog.ingredients, isEmpty);
  });
}