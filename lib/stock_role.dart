import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:pizza_coop/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/wallet.dart';

class StockRole {
  StockRole({required this.catalog, required this.stock, required this.wallet});

  final IngredientsCatalog catalog;
  final IngredientsStock stock;
  final Wallet wallet;

  List<PurchasableIngredient> listCatalog() {
    return catalog.ingredients;
  }

  List<StockIngredient> listStock() {
    return stock.ingredients;
  }

  void buy(StockIngredient ingredientToBuy) {
    var ingredient = catalog.buy(ingredientToBuy, wallet: wallet);
    stock.add(ingredient);
  }
}