import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:pizza_coop/ingredients/ingredients_catalog.dart';

class StockRole {
  StockRole({required this.catalog});

  final IngredientsCatalog catalog;

  List<PurchasableIngredient> listCatalog() {
    return catalog.ingredients;
  }
}