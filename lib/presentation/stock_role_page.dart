import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/ingredients_stock_bloc.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/stock_role.dart';
import 'package:pizza_coop/domain/wallet.dart';
import 'package:pizza_coop/presentation/ingredients_stock_page_view.dart';

class StockRolePage extends StatelessWidget {
  final stockRole = StockRole(
      catalog: IngredientsCatalog(),
      stock: IngredientsStock(),
      wallet: Wallet());

  StockRolePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IngredientsStockBloc(
          stockRole: stockRole),
      child: const StockRolePageView(),
    );
  }
}

class StockRolePageView extends StatelessWidget {
  const StockRolePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Role')),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            child: const Text('Inventory'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return BlocProvider.value(
                    value: BlocProvider.of<IngredientsStockBloc>(context),
                    child: const IngredientsStockPageView());
              }));
            },
          ),
          ElevatedButton(
            child: const Text('Catalog'),
            onPressed: () {
              const snackBar =
                  SnackBar(content: Text('Catalog under construction'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      )),
    );
  }
}
