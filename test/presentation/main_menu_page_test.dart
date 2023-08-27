import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pizza_coop/presentation/main_menu_page.dart';

void main() {
  testWidgets('Main Menu page contains Stock Role Button', (widgetTester) async
  {
    await widgetTester.pumpWidget(const MaterialApp(
      home: MainMenuPage(),
    ));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Stock Role'), findsOneWidget);
  });
}