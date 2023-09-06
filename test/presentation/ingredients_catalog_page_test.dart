import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_bloc.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_event.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_state.dart';

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

  // testWidgets('Should show initial state message', (widgetTester) async {
  //   when(() => mockIngredientsCatalogBloc?.state).thenReturn(InitialIngredientsCatalogState());
  //   await widgetTester.pumpWidget(MaterialApp(
  //     home: BlocProvider<IngredientsCatalogBloc>.value(
  //       value: mockIngredientsCatalogBloc!,
  //       child: const IngredientsCatalogPageView(),
  //     ),
  //   ));
  //
  //   expect(find.byType(Text), findsNWidgets(2));
  //   expect(find.text('Ingredients Catalog'), findsOneWidget);
  //   expect(find.text('InitialIngredientsCatalogView'), findsOneWidget);
  // });
}