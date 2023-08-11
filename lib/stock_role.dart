import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:pizza_coop/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/ingredients/ingredients_stock.dart';

class StockRole {
  StockRole({required this.catalog, required this.stock});

  final IngredientsCatalog catalog;
  final IngredientsStock stock;

  List<PurchasableIngredient> listCatalog() {
    return catalog.ingredients;
  }

  List<StockIngredient> listStock() {
    return stock.ingredients;
  }
}