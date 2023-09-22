import 'package:pizza_coop/domain/cook_role.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/oven.dart';
import 'package:test/test.dart';

void main() {
  test('Cook Role Initializes with an Oven', () {
    var oven = Oven();
    var ingredientsStock = IngredientsStock();
    var role = CookRole(oven, ingredientsStock);
    expect(role.oven, isNotNull);
  });

  test('Cook Role Initializes with an IngredientsStock', () {
    var oven = Oven();
    var ingredientsStock = IngredientsStock();
    var role = CookRole(oven, ingredientsStock);
    expect(role.ingredientsStock, isNotNull);
  });
}