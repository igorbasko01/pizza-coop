abstract class Ingredient {
  String get name;
}

class PurchasableIngredient extends Ingredient {
  @override
  final String name;
  final double cost;

  PurchasableIngredient(this.name, this.cost);
}

class StockIngredient extends Ingredient {
  @override
  final String name;
  final double amount;

  StockIngredient(this.name, this.amount);
}