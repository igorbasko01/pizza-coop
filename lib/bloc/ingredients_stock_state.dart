import 'package:pizza_coop/domain/ingredients/ingredient.dart';

sealed class IngredientsStockState {}

class InitialIngredientsStockState extends IngredientsStockState {}

class LoadingIngredientsStockState extends IngredientsStockState {}

class LoadedIngredientsStockState extends IngredientsStockState {
  final List<StockIngredient> ingredientStocks;

  LoadedIngredientsStockState(this.ingredientStocks);
}

class ErrorIngredientsStockState extends IngredientsStockState {
  final String message;

  ErrorIngredientsStockState(this.message);
}