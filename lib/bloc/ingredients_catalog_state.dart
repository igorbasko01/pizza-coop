import 'package:pizza_coop/domain/ingredients/ingredient.dart';

sealed class IngredientsCatalogState {}

class InitialIngredientsCatalogState extends IngredientsCatalogState {}

class LoadingIngredientsCatalogState extends IngredientsCatalogState {}

class LoadedIngredientsCatalogState extends IngredientsCatalogState {
  final List<PurchasableIngredient> ingredients;

  LoadedIngredientsCatalogState(this.ingredients);
}

class ErrorIngredientsCatalogState extends IngredientsCatalogState {
  final String message;

  ErrorIngredientsCatalogState(this.message);
}