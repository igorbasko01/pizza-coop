import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:pizza_coop/ingredients/ingredients_stock.dart';
import 'package:test/test.dart';

void main() {
  test('Stock initializes empty', () {
    var stock = IngredientsStock();
    expect(stock.ingredients, isEmpty);
  });

  test('Stock add adds a new ingredient', () {
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    expect(stock.ingredients, isNotEmpty);
    expect(stock.ingredients.length, 1);
    expect(stock.ingredients[0].name, 'Flour');
    expect(stock.ingredients[0].amount, 1.5);
  });

  test('Stock add adds to existing ingredient', () {
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    stock.add(StockIngredient('Flour', 1.5));
    expect(stock.ingredients, isNotEmpty);
    expect(stock.ingredients.length, 1);
    expect(stock.ingredients[0].name, 'Flour');
    expect(stock.ingredients[0].amount, 3.0);
  });

  test('Stock add adds multiple StockIngredients', () {
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    stock.add(StockIngredient('Tomato Sauce', 0.5));
    stock.add(StockIngredient('Cheese', 2.0));
    expect(stock.ingredients, isNotEmpty);
    expect(stock.ingredients.length, 3);
    expect(stock.ingredients[0].name, 'Flour');
    expect(stock.ingredients[0].amount, 1.5);
    expect(stock.ingredients[1].name, 'Tomato Sauce');
    expect(stock.ingredients[1].amount, 0.5);
    expect(stock.ingredients[2].name, 'Cheese');
    expect(stock.ingredients[2].amount, 2.0);
  });
}