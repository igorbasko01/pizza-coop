import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pizza_coop/presentation/main_menu_page.dart';

void main() {
  testWidgets('Main Menu page contains Stock Role Button', (widgetTester) async
  {
    await widgetTester.pumpWidget(const MaterialApp(
      home: MainMenuPage(),
    ));
    expect(find.widgetWithText(ElevatedButton, 'Stock Role'), findsOneWidget);
  });

  testWidgets('Main Menu page contains Waiter Role Button', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: MainMenuPage(),
    ));
    expect(find.widgetWithText(ElevatedButton, 'Waiter Role'), findsOneWidget);
  });

  testWidgets('Waiter Role Button navigates to WaiterRolePageView', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: MainMenuPage(),
    ));
    await widgetTester.tap(find.widgetWithText(ElevatedButton, 'Waiter Role'));
    await widgetTester.pumpAndSettle();
    expect(find.text('Waiter Role Page'), findsOneWidget);
  });
}