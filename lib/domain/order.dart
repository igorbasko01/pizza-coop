import 'package:pizza_coop/domain/customer.dart';
import 'package:pizza_coop/domain/recipe.dart';

class Order {
  final Recipe recipe;
  final Customer customer;

  Order(this.recipe, this.customer);
}