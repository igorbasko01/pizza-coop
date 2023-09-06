import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_bloc.dart';
import 'package:pizza_coop/bloc/ingredients_stock_bloc.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/stock_role.dart';
import 'package:pizza_coop/domain/wallet.dart';
import 'package:pizza_coop/presentation/ingredients_catalog_page_view.dart';
import 'package:pizza_coop/presentation/ingredients_stock_page_view.dart';

class StockRolePage extends StatelessWidget {
  final stockRole = StockRole(
      catalog: IngredientsCatalog(ingredients: [
        PurchasableIngredient('flour', 5),
        PurchasableIngredient('tomato', 10)
      ]),
      stock: IngredientsStock(ingredients: [StockIngredient('flour', 10)]),
      wallet: Wallet());

  StockRolePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IngredientsCatalogBloc>(
          create: (context) => IngredientsCatalogBloc(stockRole: stockRole),
        ),
        BlocProvider<IngredientsStockBloc>(
          create: (context) => IngredientsStockBloc(stockRole: stockRole),
        ),],
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
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return BlocProvider.value(
                  value: BlocProvider.of<IngredientsCatalogBloc>(context),
                  child: const IngredientsCatalogPageView());
              }));
            },
          ),
        ],
      )),
    );
  }
}
