import 'package:pizza_coop/domain/ingredients/ingredient.dart';

sealed class IngredientsCatalogEvent {}

class LoadIngredientsCatalogEvent extends IngredientsCatalogEvent {}

class BuyIngredientsCatalogEvent extends IngredientsCatalogEvent {
  final PurchasableIngredient ingredient;
  final int amount;

  BuyIngredientsCatalogEvent(this.ingredient, this.amount);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BuyIngredientsCatalogEvent &&
        other.ingredient == ingredient &&
        other.amount == amount;
  }

  @override
  int get hashCode => ingredient.hashCode ^ amount.hashCode;
}