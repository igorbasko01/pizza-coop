import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pizza_coop/bloc/stock_role_bloc.dart';
import 'package:pizza_coop/bloc/stock_role_event.dart';
import 'package:pizza_coop/bloc/stock_role_state.dart';
import 'package:pizza_coop/presentation/stock_role_page.dart';

class MockStockRoleBloc extends MockBloc<StockRoleEvent, StockRoleState>
    implements StockRoleBloc {}

void main() {
  MockStockRoleBloc? mockStockRoleBloc;

  setUp(() {
    mockStockRoleBloc = MockStockRoleBloc();
  });

  tearDown(() {
    mockStockRoleBloc?.close();
  });

  testWidgets('should show Load Ingredients button when in Initial state', (
      widgetTester) async {
    when(() => mockStockRoleBloc?.state).thenReturn(InitialStockRoleState());
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<StockRoleBloc>.value(
        value: mockStockRoleBloc!,
        child: const StockRolePageView(),
      ),
    ));

    expect(find.byType(Text), findsNWidgets(2));
    expect(find.text('Stock Role'), findsOneWidget);
    expect(find.text('InitialStockRoleView'), findsOneWidget);
  });
}