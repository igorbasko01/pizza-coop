import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/stock_role_bloc.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/stock_role.dart';
import 'package:pizza_coop/domain/wallet.dart';
import 'package:pizza_coop/presentation/ingredients_stock_page_view.dart';

class StockRolePage extends StatelessWidget {
  const StockRolePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockRoleBloc(
          stockRole: StockRole(
              catalog: IngredientsCatalog(),
              stock: IngredientsStock(),
              wallet: Wallet())),
      child: const IngredientsStockPageView(),
    );
  }
}