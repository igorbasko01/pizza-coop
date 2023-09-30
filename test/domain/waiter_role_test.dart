import 'package:pizza_coop/domain/customer.dart';
import 'package:pizza_coop/domain/customers.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/order.dart';
import 'package:pizza_coop/domain/recipe.dart';
import 'package:pizza_coop/domain/waiter_role.dart';
import 'package:test/test.dart';

void main() {
  test('Waiter Role initialized with a list of customers', () {
    var customers = Customers([
      Customer(1, 'John Doe'),
      Customer(2, 'Jane Doe'),
    ]);
    var menu = Menu(recipes: [
      Recipe('Pizza', [
        StockIngredient('Flour', 1.5),
        StockIngredient('Tomato Sauce', 0.5),
        StockIngredient('Cheese', 2.0),
      ]),
      Recipe('Pasta', [
        StockIngredient('Flour', 1.0),
        StockIngredient('Tomato Sauce', 0.5),
      ]),
    ]);
    var waiter = WaiterRole(menu, customers, PreparedIngredients());
    expect(waiter.customers, customers);
  });

  test('Waiter Role takes an order from customer specific customer', () {
    var customers = Customers([
      Customer(1, 'John Doe'),
      Customer(2, 'Jane Doe'),
    ]);
    var menu = Menu(recipes: [
      Recipe('Pizza', [
        StockIngredient('Flour', 1.5),
        StockIngredient('Tomato Sauce', 0.5),
        StockIngredient('Cheese', 2.0),
      ]),
      Recipe('Pasta', [
        StockIngredient('Flour', 1.0),
        StockIngredient('Tomato Sauce', 0.5),
      ]),
    ]);
    var waiter = WaiterRole(menu, customers, PreparedIngredients());
    var customer = customers.getCustomer(1);
    var order = waiter.takeOrder(customer.id);
    var expectedOrder = Order(menu.recipes.first, customer);
    expect(order, expectedOrder);
  });

  test('Waiter Role holds the Prepared Ingredients', () {
    var customers = Customers([]);
    var menu = Menu(recipes: []);
    var preparedIngredients = PreparedIngredients();
    var waiter = WaiterRole(menu, customers, preparedIngredients);
    expect(waiter.preparedIngredients.ingredients, isEmpty);
  });

  test(
      'When passing an ingredient to the customer, the ingredient should be removed from the prepared ingredients',
      () {
    var customerId = 1;
    var ingredientName = 'Margherita';
    var customers = Customers([Customer(customerId, 'John Doe')]);
    var menu = Menu(recipes: [
      Recipe(ingredientName, [
        StockIngredient('Flour', 1.5),
        StockIngredient('Tomato Sauce', 0.5),
        StockIngredient('Cheese', 2.0)
      ])
    ]);
    var preparedIngredients = PreparedIngredients(ingredients: [StockIngredient(ingredientName, 1)]);
    var waiter = WaiterRole(menu, customers, preparedIngredients);
    customers.customers[0].selectRecipe(menu);
    waiter.passIngredient(ingredientName, customerId);
    expect(waiter.preparedIngredients.ingredients, isEmpty);
  });

  test('When passed not selected by customer ingredient, throw an exception', () {
    var customerId = 1;
    var ingredientName = 'Margherita';
    var customers = Customers([Customer(customerId, 'John Doe')]);
    var menu = Menu(recipes: [
      Recipe(ingredientName, [
        StockIngredient('Flour', 1.5),
        StockIngredient('Tomato Sauce', 0.5),
        StockIngredient('Cheese', 2.0)
      ]), Recipe('Pasta', [
        StockIngredient('Flour', 1.0),
        StockIngredient('Tomato Sauce', 0.5),
      ])
    ]);
    var preparedIngredients = PreparedIngredients(ingredients: [
      StockIngredient(ingredientName, 1),
      StockIngredient('Pasta', 1)]);
    customers.customers[0].selectRecipe(menu);
    var waiter = WaiterRole(menu, customers, preparedIngredients);
    expect(waiter.passIngredient('Pasta', customerId).exception,
        isA<UnwantedIngredientException>());
    expect(preparedIngredients.ingredients.length, 2);
    expect(preparedIngredients.ingredients[0].name, ingredientName);
    expect(preparedIngredients.ingredients[0].amount, 1);
    expect(preparedIngredients.ingredients[1].name, 'Pasta');
    expect(preparedIngredients.ingredients[1].amount, 1);
  });

  test('when not enough of prepared ingredient is passed to the customer throw an exception', () {
    var customerId = 1;
    var ingredientName = 'Margherita';
    var customers = Customers([Customer(customerId, 'John Doe')]);
    var menu = Menu(recipes: [
      Recipe(ingredientName, [
        StockIngredient('Flour', 1.5),
        StockIngredient('Tomato Sauce', 0.5),
        StockIngredient('Cheese', 2.0)
      ])
    ]);
    var preparedIngredients = PreparedIngredients(ingredients: [
      StockIngredient(ingredientName, 0.5),
    ]);
    customers.customers[0].selectRecipe(menu);
    var waiter = WaiterRole(menu, customers, preparedIngredients);
    expect(waiter.passIngredient(ingredientName, customerId).exception,
        isA<InsufficientIngredientException>());
    expect(preparedIngredients.ingredients.length, 1);
    expect(preparedIngredients.ingredients[0].name, ingredientName);
    expect(preparedIngredients.ingredients[0].amount, 0.5);
  });
}
