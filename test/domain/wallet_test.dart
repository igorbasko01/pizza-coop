import 'package:pizza_coop/domain/wallet.dart';
import 'package:test/test.dart';

void main() {
  test('wallet initial balance is 0', () {
    var wallet = Wallet();
    expect(wallet.balance, 0);
  });

  test('wallet deduct succeeds when sufficient balance', () {
    var wallet = Wallet(balance: 10);
    expect(wallet.deduct(5), true);
    expect(wallet.balance, 5);
  });

  test('wallet deduct fails when insufficient balance', () {
    var wallet = Wallet(balance: 10);
    expect(wallet.deduct(11), false);
    expect(wallet.balance, 10);
  });
}