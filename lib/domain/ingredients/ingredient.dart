abstract class Ingredient {
  String get name;
}

class PurchasableIngredient extends Ingredient {
  @override
  final String name;
  final double cost;

  PurchasableIngredient(this.name, this.cost);
}

class InsufficientIngredientException implements Exception {
  final String message;

  InsufficientIngredientException(this.message);
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

  void subtract(double amount) {
    if (amount > _amount) {
      throw InsufficientIngredientException(
          'Insufficient ingredient, needed: $amount, available: $_amount');
    }
    _amount -= amount;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockIngredient &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          _amount == other._amount;

  @override
  int get hashCode => name.hashCode ^ _amount.hashCode;
}