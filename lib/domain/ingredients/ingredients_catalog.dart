import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/wallet.dart';

class IngredientsCatalog {
  List<PurchasableIngredient> _ingredients = [];

  List<PurchasableIngredient> get ingredients => _ingredients;

  IngredientsCatalog({List<PurchasableIngredient>? ingredients}) {
    if (ingredients != null) {
      _ingredients = ingredients;
    }
  }

  StockIngredient buy(StockIngredient stockIngredient,
      {required Wallet wallet}) {
    var ingredient = _ingredients.firstWhere(
        (ingredient) => ingredient.name == stockIngredient.name,
        orElse: () => throw IngredientNotFoundException(
            'Ingredient ${stockIngredient.name} not found'));
    var cost = ingredient.cost * stockIngredient.amount;
    if (wallet.deduct(cost)) {
      return StockIngredient(stockIngredient.name, stockIngredient.amount);
    } else {
      throw InsufficientFundsException(
          'Insufficient funds, needed: $cost, available: ${wallet.balance}');
    }
  }
}

class IngredientNotFoundException implements Exception {
  final String message;

  IngredientNotFoundException(this.message);
}

class InsufficientFundsException implements Exception {
  final String message;

  InsufficientFundsException(this.message);
}
