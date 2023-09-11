import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_bloc.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_event.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_state.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/wallet.dart';
import 'package:pizza_coop/presentation/ingredients_catalog_page_view.dart';

class MockIngredientsCatalogBloc
    extends MockBloc<IngredientsCatalogEvent, IngredientsCatalogState>
    implements IngredientsCatalogBloc {}

void main() {
  MockIngredientsCatalogBloc? mockIngredientsCatalogBloc;

  setUp(() {
    mockIngredientsCatalogBloc = MockIngredientsCatalogBloc();
  });

  tearDown(() {
    mockIngredientsCatalogBloc?.close();
  });

  testWidgets('Should show initial state message', (widgetTester) async {
    when(() => mockIngredientsCatalogBloc?.state)
        .thenReturn(InitialIngredientsCatalogState());
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<IngredientsCatalogBloc>.value(
        value: mockIngredientsCatalogBloc!,
        child: const IngredientsCatalogPageView(),
      ),
    ));

    expect(find.byType(Text), findsNWidgets(2));
    expect(find.text('Ingredients Catalog'), findsOneWidget);
    expect(find.text('InitialIngredientsCatalogView'), findsOneWidget);
  });

  testWidgets('Should show loading state message', (widgetTester) async {
    when(() => mockIngredientsCatalogBloc?.state)
        .thenReturn(LoadingIngredientsCatalogState());
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<IngredientsCatalogBloc>.value(
        value: mockIngredientsCatalogBloc!,
        child: const IngredientsCatalogPageView(),
      ),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should show loaded state message', (widgetTester) async {
    when(() => mockIngredientsCatalogBloc?.state).thenReturn(
        LoadedIngredientsCatalogState([
      PurchasableIngredient('Flour', 10),
      PurchasableIngredient('Tomato', 10)
    ], Wallet(balance: 20)));
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<IngredientsCatalogBloc>.value(
        value: mockIngredientsCatalogBloc!,
        child: const IngredientsCatalogPageView(),
      ),
    ));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(2));
  });

  testWidgets('Invokes BuyIngredientsCatalogEvent when Buy button is pressed',
      (widgetTester) async {
    final flourIngredient = PurchasableIngredient('Flour', 10);
    when(() => mockIngredientsCatalogBloc?.state).thenReturn(
        LoadedIngredientsCatalogState([
      flourIngredient,
      PurchasableIngredient('Tomato', 10)
    ], Wallet(balance: 20)));
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<IngredientsCatalogBloc>.value(
        value: mockIngredientsCatalogBloc!,
        child: const IngredientsCatalogPageView(),
      ),
    ));

    await widgetTester.tap(find.byType(IconButton).first);
    verify(() => mockIngredientsCatalogBloc?.add(
            BuyIngredientsCatalogEvent(flourIngredient, 1)))
        .called(1);
  });
}
