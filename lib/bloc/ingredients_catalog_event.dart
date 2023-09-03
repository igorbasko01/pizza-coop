import 'package:pizza_coop/domain/ingredients/ingredient.dart';

sealed class IngredientsCatalogEvent {}

class LoadIngredientsCatalogEvent extends IngredientsCatalogEvent {}

class BuyIngredientsCatalogEvent extends IngredientsCatalogEvent {
  final PurchasableIngredient ingredient;
  final int amount;

  BuyIngredientsCatalogEvent(this.ingredient, this.amount);
}