import 'package:pizza_coop/domain/customers.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/order.dart';
import 'package:pizza_coop/utils/result.dart';

class WaiterRole {
  final Menu menu;
  final Customers customers;
  final PreparedIngredients preparedIngredients;

  WaiterRole(this.menu, this.customers, this.preparedIngredients);

  Order takeOrder(int customerId) {
    var customer = customers.getCustomer(customerId);
    var recipe = customer.selectRecipe(menu);
    return Order(recipe, customer);
  }

  Result<void> passIngredient(String ingredientName, int customerId) {
    var customer = customers.getCustomer(customerId);
    var ingredientToUse = StockIngredient(ingredientName, 1);
    var used = preparedIngredients.use(ingredientToUse);
    if (used.isFailure) {
      return Result.failure(used.exception!);
    }
    var accepted = customer.accept(ingredientToUse);
    if (accepted.isFailure) {
      preparedIngredients.add(ingredientToUse);  // Put back the used ingredient.
      return Result.failure(accepted.exception!);
    } else {
      return Result.success(null);
    }
  }
}