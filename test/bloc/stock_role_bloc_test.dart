import 'package:pizza_coop/bloc/stock_role_bloc.dart';
import 'package:pizza_coop/bloc/stock_role_state.dart';
import 'package:test/test.dart';

void main() {
  StockRoleBloc? stockRoleBloc;

  setUp(() {
    stockRoleBloc = StockRoleBloc();
  });

  tearDown(() {
    stockRoleBloc?.close();
  });

  test('StockRoleBloc initializes with correct initial state', () {
    expect(stockRoleBloc?.state.runtimeType, InitialStockRoleState);
  });
}