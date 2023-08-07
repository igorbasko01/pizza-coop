import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:test/test.dart';

void main() {
  test('Create ingredient that has a cost', () {
    var ingredient = PurchasableIngredient('Flour', 1.5);
    expect(ingredient.name, 'Flour');
    expect(ingredient.cost, 1.5);
  });

  test('Create ingredient that is in stock', () {
    var ingredient = StockIngredient('Flour', 1.5);
    expect(ingredient.name, 'Flour');
    expect(ingredient.amount, 1.5);
  });

  test('Add amount to existing StockIngredient', () {
    var ingredient = StockIngredient('Flour', 1.5);
    ingredient.add(1.5);
    expect(ingredient.amount, 3.0);
  });
}