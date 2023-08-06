import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:pizza_coop/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/wallet.dart';
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

  test('IngredientsCatalog buy returns bought ingredients', () {
    var catalog = IngredientsCatalog(ingredients: [
      PurchasableIngredient('Flour', 1.5),
      PurchasableIngredient('Tomato Sauce', 0.5),
      PurchasableIngredient('Cheese', 2.0),
    ]);
    var bought = catalog.buy(StockIngredient('Flour', 2), wallet: Wallet(balance: 10));
    expect(bought, isNotNull);
    expect(bought, isA<StockIngredient>());
    expect(bought.name, 'Flour');
    expect(bought.amount, 2);
  });

  test('IngredientsCatalog buy throws exception when insufficient funds', () {
    var catalog = IngredientsCatalog(ingredients: [
      PurchasableIngredient('Flour', 1.5),
      PurchasableIngredient('Tomato Sauce', 0.5),
      PurchasableIngredient('Cheese', 2.0),
    ]);
    expect(() => catalog.buy(StockIngredient('Flour', 2), wallet: Wallet(balance: 1)), throwsA(isA<InsufficientFundsException>()));
  });

  test('IngredientsCatalog buy deducts funds from wallet', () {
    var catalog = IngredientsCatalog(ingredients: [
      PurchasableIngredient('Flour', 1.5),
      PurchasableIngredient('Tomato Sauce', 0.5),
      PurchasableIngredient('Cheese', 2.0),
    ]);
    var wallet = Wallet(balance: 10);
    catalog.buy(StockIngredient('Flour', 2), wallet: wallet);
    expect(wallet.balance, 7);
  });

  test('IngredientsCatalog buy throws exception when passed invalid ingredient', () {
    var catalog = IngredientsCatalog(ingredients: [
      PurchasableIngredient('Flour', 1.5),
      PurchasableIngredient('Tomato Sauce', 0.5),
      PurchasableIngredient('Cheese', 2.0),
    ]);
    expect(() => catalog.buy(StockIngredient('Pepperoni', 2), wallet: Wallet(balance: 10)), throwsA(isA<IngredientNotFoundException>()));
  });
}