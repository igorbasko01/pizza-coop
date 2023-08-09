import 'package:pizza_coop/ingredients/ingredient.dart';
import 'package:pizza_coop/ingredients/ingredients_catalog.dart';
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

  test('Stock use removes from existing ingredient', () {
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    stock.use(StockIngredient('Flour', 1.0));
    expect(stock.ingredients, isNotEmpty);
    expect(stock.ingredients.length, 1);
    expect(stock.ingredients[0].name, 'Flour');
    expect(stock.ingredients[0].amount, 0.5);
  });

  test('Stock use throws exception if there is insufficient ingredient', () {
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    expect(() => stock.use(StockIngredient('Flour', 2.0)), throwsA(isA<InsufficientIngredientException>()));
  });

  test('Stock use throws exception if there is no such ingredient', () {
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    expect(() => stock.use(StockIngredient('Tomato Sauce', 1.0)), throwsA(isA<IngredientNotFoundException>()));
  });

  test('Stock use should remove ingredient if reaches zero amount', () {
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    stock.use(StockIngredient('Flour', 1.5));
    expect(stock.ingredients, isEmpty);
  });

  test('Stock useAll removes from existing ingredients', () {
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    stock.add(StockIngredient('Tomato Sauce', 1.0));
    stock.add(StockIngredient('Cheese', 2.0));
    stock.useAll([
      StockIngredient('Flour', 1.0),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 1.0),
    ]);
    expect(stock.ingredients, isNotEmpty);
    expect(stock.ingredients.length, 3);
    expect(stock.ingredients[0].name, 'Flour');
    expect(stock.ingredients[0].amount, 0.5);
    expect(stock.ingredients[1].name, 'Tomato Sauce');
    expect(stock.ingredients[1].amount, 0.5);
    expect(stock.ingredients[2].name, 'Cheese');
    expect(stock.ingredients[2].amount, 1.0);
  });

  test('Stock useAll wont subtract any ingredient if one ingredient has not enough amount', () {
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    stock.add(StockIngredient('Tomato Sauce', 1.0));
    stock.add(StockIngredient('Cheese', 2.0));
    expect(() => stock.useAll([
      StockIngredient('Flour', 1.0),
      StockIngredient('Tomato Sauce', 0.5),
      StockIngredient('Cheese', 3.0),
    ]), throwsA(isA<InsufficientIngredientException>()));
    expect(stock.ingredients, isNotEmpty);
    expect(stock.ingredients.length, 3);
    expect(stock.ingredients[0].name, 'Flour');
    expect(stock.ingredients[0].amount, 1.5);
    expect(stock.ingredients[1].name, 'Tomato Sauce');
    expect(stock.ingredients[1].amount, 1.0);
    expect(stock.ingredients[2].name, 'Cheese');
    expect(stock.ingredients[2].amount, 2.0);
  });

  test('Stock useAll throws exception if there is no such ingredient', () {
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    expect(() => stock.useAll([StockIngredient('Tomato Sauce', 1.0)]), throwsA(isA<IngredientNotFoundException>()));
  });

  test('Stock useAll should remove ingredient if reaches zero amount', () {
    var stock = IngredientsStock();
    stock.add(StockIngredient('Flour', 1.5));
    stock.add(StockIngredient('Tomato Sauce', 1.0));
    stock.add(StockIngredient('Cheese', 2.0));
    stock.useAll([
      StockIngredient('Cheese', 1.0),
      StockIngredient('Flour', 1.5),
      StockIngredient('Tomato Sauce', 1.0),
    ]);
    expect(stock.ingredients, isNotEmpty);
    expect(stock.ingredients.length, 1);
    expect(stock.ingredients[0].name, 'Cheese');
    expect(stock.ingredients[0].amount, 1.0);
  });
}