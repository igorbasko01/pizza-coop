import 'package:flutter/material.dart';
import 'package:pizza_coop/presentation/stock_role_page.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Menu')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Stock Role'),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const StockRolePage()));
          },
        ),
      ),
    );
  }
}
