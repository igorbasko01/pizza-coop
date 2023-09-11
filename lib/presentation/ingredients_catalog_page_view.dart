import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_bloc.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_event.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_state.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/wallet.dart';

class IngredientsCatalogPageView extends StatelessWidget {
  const IngredientsCatalogPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingredients Catalog')),
      body: BlocConsumer<IngredientsCatalogBloc, IngredientsCatalogState>(
        listener: (context, state) {
          if (state is NotificationMessageCatalogState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is InitialIngredientsCatalogState) {
            return const _InitialIngredientsCatalogView();
          } else if (state is LoadingIngredientsCatalogState) {
            return _LoadingIngredientsCatalogView();
          } else if (state is LoadedIngredientsCatalogState) {
            return _LoadedIngredientsCatalogView(
                ingredients: state.ingredients, wallet: state.wallet);
          } else if (state is ErrorIngredientsCatalogState) {
            return _ErrorIngredientsCatalogView(message: state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _InitialIngredientsCatalogView extends StatelessWidget {
  const _InitialIngredientsCatalogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<IngredientsCatalogBloc>(context)
        .add(LoadIngredientsCatalogEvent());
    return const Center(child: Text('InitialIngredientsCatalogView'));
  }
}

class _LoadingIngredientsCatalogView extends StatelessWidget {
  const _LoadingIngredientsCatalogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _LoadedIngredientsCatalogView extends StatelessWidget {
  final List<PurchasableIngredient> ingredients;
  final Wallet wallet;

  const _LoadedIngredientsCatalogView(
      {Key? key, required this.ingredients, required this.wallet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(padding: EdgeInsets.all(16.0),
            child: Text(
                'Balance ${wallet.balance}',
                style: const TextStyle(fontSize: 24))
          ),
          Expanded(
            child: _IngredientsCatalogListView(ingredients: ingredients),
          ),
        ]
    );
  }
}

class _IngredientsCatalogListView extends StatelessWidget {
  final List<PurchasableIngredient> ingredients;

  const _IngredientsCatalogListView({Key? key, required this.ingredients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(ingredients[index].name),
          subtitle: Text(ingredients[index].cost.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final ingredientToBuy = ingredients[index];
              BlocProvider.of<IngredientsCatalogBloc>(context).add(
                  BuyIngredientsCatalogEvent(ingredientToBuy, 1));
            },
          ),
        );
      },
    );
  }
}

class _ErrorIngredientsCatalogView extends StatelessWidget {
  final String message;

  const _ErrorIngredientsCatalogView({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
