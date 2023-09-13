import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/recipe.dart';

class Customer {
  String name;
  Customer(this.name);

  Recipe selectRecipe(Menu menu) {
    return menu.recipes.first;
  }
}