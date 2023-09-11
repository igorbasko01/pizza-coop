import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/wallet.dart';

sealed class IngredientsCatalogState {}

class InitialIngredientsCatalogState extends IngredientsCatalogState {}

class LoadingIngredientsCatalogState extends IngredientsCatalogState {}

class LoadedIngredientsCatalogState extends IngredientsCatalogState {
  final List<PurchasableIngredient> ingredients;
  final Wallet wallet;

  LoadedIngredientsCatalogState(this.ingredients, this.wallet);
}

class ErrorIngredientsCatalogState extends IngredientsCatalogState {
  final String message;

  ErrorIngredientsCatalogState(this.message);
}

class NotificationMessageCatalogState extends IngredientsCatalogState {
  final String message;

  NotificationMessageCatalogState(this.message);
}