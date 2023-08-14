import 'package:pizza_coop/domain/ingredients/ingredient.dart';

sealed class StockRoleState {}

class InitialStockRoleState extends StockRoleState {}

class LoadingIngredientsStockRoleState extends StockRoleState {}

class LoadedIngredientsStockRoleState extends StockRoleState {
  final List<StockIngredient> ingredientStocks;

  LoadedIngredientsStockRoleState(this.ingredientStocks);
}

class ErrorStockRoleState extends StockRoleState {
  final String message;

  ErrorStockRoleState(this.message);
}