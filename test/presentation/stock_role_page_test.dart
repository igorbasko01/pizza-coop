import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pizza_coop/bloc/stock_role_bloc.dart';
import 'package:pizza_coop/bloc/stock_role_event.dart';
import 'package:pizza_coop/bloc/stock_role_state.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/presentation/ingredients_stock_page_view.dart';
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
        child: const IngredientsStockPageView(),
      ),
    ));

    expect(find.byType(Text), findsNWidgets(2));
    expect(find.text('Stock Role'), findsOneWidget);
    expect(find.text('InitialStockRoleView'), findsOneWidget);
  });

  testWidgets('should show Loading widget when loading stock ingredients', (widgetTester) async {
    when(() => mockStockRoleBloc?.state).thenReturn(LoadingIngredientsStockRoleState());
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<StockRoleBloc>.value(
        value: mockStockRoleBloc!,
        child: const IngredientsStockPageView(),
      ),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show Loaded stock ingredients in a list', (widgetTester) async {
    when(() => mockStockRoleBloc?.state).thenReturn(LoadedIngredientsStockRoleState([
      StockIngredient('Flour', 10),
      StockIngredient('Tomato', 10)
    ]));
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<StockRoleBloc>.value(
        value: mockStockRoleBloc!,
        child: const IngredientsStockPageView(),
      ),
    ));
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(2));
    expect(find.text('Flour'), findsOneWidget);
    expect(find.text('Tomato'), findsOneWidget);
  });

  testWidgets('should show Error message on error', (widgetTester) async {
    when(() => mockStockRoleBloc?.state).thenReturn(ErrorStockRoleState('Error'));
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<StockRoleBloc>.value(
        value: mockStockRoleBloc!,
        child: const IngredientsStockPageView(),
      ),
    ));
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.text('Error'), findsOneWidget);
    expect(find.text('Stock Role'), findsOneWidget);
  });

  testWidgets('StockRolePageView has an Inventory stock and catalog buttons', (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<StockRoleBloc>.value(
        value: mockStockRoleBloc!,
        child: const StockRolePageView(),
      ),
    ));
    expect(find.byType(ElevatedButton), findsNWidgets(2));
    expect(find.text('Inventory'), findsOneWidget);
    expect(find.text('Catalog'), findsOneWidget);
  });
}