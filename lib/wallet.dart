class Wallet {
  int _balance;

  Wallet({int balance = 0}) : _balance = balance;

  int get balance => _balance;

  bool deduct(int amount) {
    if (amount > _balance) {
      return false;
    }
    _balance -= amount;
    return true;
  }
}