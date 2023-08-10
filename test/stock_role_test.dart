import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:pizza_coop/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/stock_role.dart';
import 'package:test/test.dart';

void main() {
  test('Stock Role listCatalog returns a list of PurchasableIngredients', () {
    var catalog = IngredientsCatalog(ingredients: [
      PurchasableIngredient('Flour', 1.5),
      PurchasableIngredient('Tomato Sauce', 0.5),
      PurchasableIngredient('Cheese', 2.0),
    ]);
    var stock = StockRole(catalog: catalog);
    var catalogIngredients = stock.listCatalog();
    expect(catalogIngredients, isNotEmpty);
    expect(catalogIngredients.length, 3);
    expect(catalogIngredients[0].name, 'Flour');
    expect(catalogIngredients[0].cost, 1.5);
    expect(catalogIngredients[1].name, 'Tomato Sauce');
    expect(catalogIngredients[1].cost, 0.5);
    expect(catalogIngredients[2].name, 'Cheese');
    expect(catalogIngredients[2].cost, 2.0);
  });
}