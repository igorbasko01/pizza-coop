import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/oven.dart';

class CookRole {
  final Oven oven;
  final IngredientsStock ingredientsStock;

  CookRole(this.oven, this.ingredientsStock);
}