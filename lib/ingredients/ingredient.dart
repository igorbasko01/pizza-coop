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
  double _amount;

  double get amount => _amount;

  StockIngredient(this.name, this._amount);

  void add(double amount) {
    _amount += amount;
  }
}