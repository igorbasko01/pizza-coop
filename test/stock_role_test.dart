import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:pizza_coop/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/stock_role.dart';
import 'package:pizza_coop/wallet.dart';
import 'package:test/test.dart';

void main() {
  test('Stock Role listCatalog returns a list of PurchasableIngredients', () {
    var catalog = IngredientsCatalog(ingredients: [
      PurchasableIngredient('Flour', 1.5),
      PurchasableIngredient('Tomato Sauce', 0.5),
      PurchasableIngredient('Cheese', 2.0),
    ]);
    var wallet = Wallet(balance: 10);
    var stock = IngredientsStock();
    var role = StockRole(catalog: catalog, stock: stock, wallet: wallet);
    var catalogIngredients = role.listCatalog();
    expect(catalogIngredients, isNotEmpty);
    expect(catalogIngredients.length, 3);
    expect(catalogIngredients[0].name, 'Flour');
    expect(catalogIngredients[0].cost, 1.5);
    expect(catalogIngredients[1].name, 'Tomato Sauce');
    expect(catalogIngredients[1].cost, 0.5);
    expect(catalogIngredients[2].name, 'Cheese');
    expect(catalogIngredients[2].cost, 2.0);
  });

  test('Stock Role listStock returns list of StockIngredients', () {
    var catalog = IngredientsCatalog(ingredients: [
      PurchasableIngredient('Flour', 1.5),
      PurchasableIngredient('Tomato Sauce', 0.5),
      PurchasableIngredient('Cheese', 2.0),
    ]);
    var stock = IngredientsStock(ingredients: [
      StockIngredient('Flour', 1.0),
      StockIngredient('Tomato Sauce', 1.5),
      StockIngredient('Cheese', 2.5),
    ]);
    var wallet = Wallet(balance: 10);
    var role = StockRole(catalog: catalog, stock: stock, wallet: wallet);
    var stockIngredients = role.listStock();
    expect(stockIngredients, isNotEmpty);
    expect(stockIngredients.length, 3);
    expect(stockIngredients[0].name, 'Flour');
    expect(stockIngredients[0].amount, 1.0);
    expect(stockIngredients[1].name, 'Tomato Sauce');
    expect(stockIngredients[1].amount, 1.5);
    expect(stockIngredients[2].name, 'Cheese');
    expect(stockIngredients[2].amount, 2.5);
  });

  test('Stock Role buys a single ingredient from the catalog and it is added to the stock', () {
    var catalog = IngredientsCatalog(ingredients: [
      PurchasableIngredient('Flour', 1.5),
      PurchasableIngredient('Tomato Sauce', 0.5),
      PurchasableIngredient('Cheese', 2.0),
    ]);
    var stock = IngredientsStock();
    var wallet = Wallet(balance: 10);
    var role = StockRole(catalog: catalog, stock: stock, wallet: wallet);
    role.buy(StockIngredient('Flour', 1.5));
    expect(stock.ingredients, isNotEmpty);
    expect(stock.ingredients.length, 1);
    expect(stock.ingredients[0].name, 'Flour');
    expect(stock.ingredients[0].amount, 1.5);
    expect(wallet.balance, 7.75);
  });

  test('Stock Role buy throws exception on Insufficient funds', () {
    var catalog = IngredientsCatalog(ingredients: [
      PurchasableIngredient('Flour', 1),
      PurchasableIngredient('Tomato Sauce', 0.5),
      PurchasableIngredient('Cheese', 2.0),
    ]);
    var stock = IngredientsStock();
    var wallet = Wallet(balance: 1.5);
    var role = StockRole(catalog: catalog, stock: stock, wallet: wallet);
    expect(() => role.buy(StockIngredient('Flour', 2)), throwsA(isA<InsufficientFundsException>()));
    expect(wallet.balance, 1.5);
  });

  test('Stock Role buy throws exception when no such ingredient in the catalog', () {
    var catalog = IngredientsCatalog(ingredients: [
      PurchasableIngredient('Flour', 1),
      PurchasableIngredient('Tomato Sauce', 0.5),
      PurchasableIngredient('Cheese', 2.0),
    ]);
    var stock = IngredientsStock();
    var wallet = Wallet(balance: 10);
    var role = StockRole(catalog: catalog, stock: stock, wallet: wallet);
    expect(() => role.buy(StockIngredient('Pepperoni', 2)), throwsA(isA<IngredientNotFoundException>()));
    expect(wallet.balance, 10);
  });
}
