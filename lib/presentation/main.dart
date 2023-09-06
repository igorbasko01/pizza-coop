import 'package:flutter/material.dart';
import 'package:pizza_coop/presentation/main_menu_page.dart';
import 'package:pizza_coop/presentation/stock_role_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Coop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainMenuPage(),
    );
  }
}