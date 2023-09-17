import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/recipe.dart';

class Customer {
  final int id;
  String name;

  Customer(this.id, this.name);

  Recipe selectRecipe(Menu menu) {
    return menu.recipes.first;
  }
}