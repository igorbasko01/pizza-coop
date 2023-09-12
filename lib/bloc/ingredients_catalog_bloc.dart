import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_event.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_state.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/domain/stock_role.dart';

class IngredientsCatalogBloc
    extends Bloc<IngredientsCatalogEvent, IngredientsCatalogState> {
  final StockRole stockRole;

  IngredientsCatalogBloc({required this.stockRole})
      : super(InitialIngredientsCatalogState()) {
    on<LoadIngredientsCatalogEvent>(_onLoadIngredientsCatalogEvent);
    on<BuyIngredientsCatalogEvent>(_onBuyIngredientsCatalogEvent);
  }

  void _onLoadIngredientsCatalogEvent(
    LoadIngredientsCatalogEvent event,
    Emitter<IngredientsCatalogState> emit,
  ) {
    emit(LoadingIngredientsCatalogState());
    emit(LoadedIngredientsCatalogState(stockRole.listCatalog(), stockRole.wallet));
  }

  void _onBuyIngredientsCatalogEvent(BuyIngredientsCatalogEvent event, Emitter<IngredientsCatalogState> emit) {
    try {
      stockRole.buy(StockIngredient(event.ingredient.name, event.amount.toDouble()));
      emit(NotificationMessageCatalogState('Bought ${event.ingredient.name}'));
    } on InsufficientFundsException {
      emit(NotificationMessageCatalogState('Insufficient funds to buy ${event.ingredient.name}'));
    }
    emit(LoadedIngredientsCatalogState(stockRole.listCatalog(), stockRole.wallet));
  }
}
