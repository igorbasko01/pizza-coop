import 'package:pizza_coop/domain/customer.dart';
import 'package:pizza_coop/domain/recipe.dart';

class Order {
  final Recipe recipe;
  final Customer customer;

  Order(this.recipe, this.customer);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
      other.recipe == recipe &&
      other.customer == customer;
  }

  @override
  int get hashCode => recipe.hashCode ^ customer.hashCode;
}