import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pizza_coop/bloc/waiter_role/waiter_role_bloc.dart';
import 'package:pizza_coop/bloc/waiter_role/waiter_role_event.dart';
import 'package:pizza_coop/bloc/waiter_role/waiter_role_state.dart';
import 'package:pizza_coop/domain/customer.dart';
import 'package:pizza_coop/domain/customers.dart';
import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/recipe.dart';
import 'package:pizza_coop/presentation/waiter_role_page_view.dart';

class MockWaiterRoleBloc extends MockBloc<WaiterRoleEvent, WaiterRoleState>
    implements WaiterRoleBloc {}

void main() {
  MockWaiterRoleBloc? mockWaiterRoleBloc;

  setUp(() {
    mockWaiterRoleBloc = MockWaiterRoleBloc();
  });

  tearDown(() {
    mockWaiterRoleBloc?.close();
  });

  testWidgets('should show loaded customers in a list', (widgetTester) async {
    when(() => mockWaiterRoleBloc?.state)
        .thenReturn(LoadedWaiterRoleState(Customers([
      Customer(0, 'Customer 1'),
      Customer(1, 'Customer 2'),
    ]), Menu(recipes: [])));
    await widgetTester.pumpWidget(MaterialApp(
        home: BlocProvider<WaiterRoleBloc>.value(
      value: mockWaiterRoleBloc!,
      child: const WaiterRolePageView(),
    )));
    expect(find.byType(ListView), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Customer 1'), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Customer 2'), findsOneWidget);
  });

  testWidgets(
      'When clicking on a customer in a list, it shows a snack bar with the selected recipe',
      (widgetTester) async {
    when(() => mockWaiterRoleBloc?.state).thenReturn(LoadedWaiterRoleState(
        Customers([
          Customer(0, 'Customer 1'),
          Customer(1, 'Customer 2'),
        ]),
        Menu(recipes: [Recipe('Margherita', []), Recipe('Napoletana', [])])));
    await widgetTester.pumpWidget(MaterialApp(
        home: BlocProvider<WaiterRoleBloc>.value(
      value: mockWaiterRoleBloc!,
      child: const WaiterRolePageView(),
    )));
    await widgetTester.tap(find.widgetWithText(ListTile, 'Customer 1'));
    await widgetTester.pumpAndSettle();
    expect(find.widgetWithText(SnackBar, 'Customer 1 wants: Margherita'), findsOneWidget);
  });
}
