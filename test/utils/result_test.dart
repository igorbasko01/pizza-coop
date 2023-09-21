import 'package:pizza_coop/utils/result.dart';
import 'package:test/test.dart';

class TestException implements Exception {}

class TestObject {
  final int value = 1;
}

void main() {
  test('Result returns success with int type', () {
    var result = Result.success(1);
    expect(result.isSuccess, true);
    expect(result.isFailure, false);
    expect(result.value, 1);
    expect(result.exception, null);
  });

  test('Result returns specific exception on failure', () {
    var result = Result.failure(TestException());
    expect(result.isSuccess, false);
    expect(result.isFailure, true);
    expect(result.value, null);
    expect(result.exception, isA<TestException>());
  });

  test('Result returns specific object as success', () {
    var result = Result.success(TestObject());
    expect(result.isSuccess, true);
    expect(result.isFailure, false);
    expect(result.value, isA<TestObject>());
    expect(result.value?.value, 1);
    expect(result.exception, null);
  });
}