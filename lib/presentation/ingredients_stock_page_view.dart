import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/ingredients_stock_bloc.dart';
import 'package:pizza_coop/bloc/ingredients_stock_event.dart';
import 'package:pizza_coop/bloc/ingredients_stock_state.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';

class IngredientsStockPageView extends StatelessWidget {
  const IngredientsStockPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Role')),
      body: BlocBuilder<IngredientsStockBloc, IngredientsStockState>(
        builder: (context, state) {
          if (state is InitialIngredientsStockState) {
            return const _InitialStockRoleView();
          } else if (state is LoadingIngredientsStockState) {
            return _LoadingIngredientsStockRoleView();
          } else if (state is LoadedIngredientsStockState) {
            return _LoadedIngredientsStockRoleView(
                ingredientStocks: state.ingredientStocks);
          } else if (state is ErrorIngredientsStockState) {
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
    BlocProvider.of<IngredientsStockBloc>(context).add(LoadIngredientsStockEvent());
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