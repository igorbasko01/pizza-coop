import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/stock_role_bloc.dart';
import 'package:pizza_coop/bloc/stock_role_state.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/stock_role.dart';
import 'package:pizza_coop/domain/wallet.dart';

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
      body: BlocBuilder<StockRoleBloc, StockRoleState>(
        builder: (context, state) {
          if (state is InitialStockRoleState) {
            return const _InitialStockRoleView();
          } else if (state is LoadingIngredientsStockRoleState) {
            return _LoadingIngredientsStockRoleView();
          } else if (state is LoadedIngredientsStockRoleState) {
            return _LoadedIngredientsStockRoleView(
                ingredientStocks: state.ingredientStocks);
          } else if (state is ErrorStockRoleState) {
            return _ErrorStockRoleView(message: state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _InitialStockRoleView extends StatelessWidget {
  const _InitialStockRoleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('InitialStockRoleView'));
  }
}

class _LoadingIngredientsStockRoleView extends StatelessWidget {
  const _LoadingIngredientsStockRoleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _LoadedIngredientsStockRoleView extends StatelessWidget {
  final List<StockIngredient> ingredientStocks;

  const _LoadedIngredientsStockRoleView(
      {Key? key, required this.ingredientStocks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ingredientStocks.length,
      itemBuilder: (context, index) {
        final ingredientStock = ingredientStocks[index];
        return ListTile(
          title: Text(ingredientStock.name),
          subtitle: Text(ingredientStock.amount.toString()),
        );
      },
    );
  }
}

class _ErrorStockRoleView extends StatelessWidget {
  final String message;

  const _ErrorStockRoleView({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}