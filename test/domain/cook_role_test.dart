import 'package:pizza_coop/domain/cook_role.dart';
import 'package:pizza_coop/domain/oven.dart';
import 'package:test/test.dart';

void main() {
  test('Cook Role Initializes with an Oven', () {
    var oven = Oven();
    var role = CookRole(oven);
    expect(role.oven, isNotNull);
  });
}