import 'package:pizza_coop/domain/ingredients/ingredient.dart';

sealed class IngredientStockState {}

class InitialIngredientStockState extends IngredientStockState {}

class LoadingIngredientStockState extends IngredientStockState {}

class LoadedIngredientStockState extends IngredientStockState {
  final List<StockIngredient> ingredientStocks;

  LoadedIngredientStockState(this.ingredientStocks);
}

class ErrorIngredientStockState extends IngredientStockState {
  final String message;

  ErrorIngredientStockState(this.message);
}