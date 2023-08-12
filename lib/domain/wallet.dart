class Wallet {
  double _balance;

  Wallet({double balance = 0}) : _balance = balance;

  double get balance => _balance;

  bool deduct(double amount) {
    if (amount > _balance) {
      return false;
    }
    _balance -= amount;
    return true;
  }
}