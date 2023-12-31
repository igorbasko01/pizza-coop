import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/ingredients_stock_event.dart';
import 'package:pizza_coop/bloc/ingredients_stock_state.dart';
import 'package:pizza_coop/domain/stock_role.dart';

class IngredientsStockBloc extends Bloc<IngredientsStockEvent, IngredientsStockState> {
  final StockRole stockRole;

  IngredientsStockBloc({required this.stockRole}) : super(InitialIngredientsStockState()) {
    on<LoadIngredientsStockEvent>(_onLoadIngredientsStockRoleEvent);
  }

  void _onLoadIngredientsStockRoleEvent(
      LoadIngredientsStockEvent event, Emitter<IngredientsStockState> emit) {
    emit(LoadingIngredientsStockState());
    emit(LoadedIngredientsStockState(stockRole.listStock()));
  }
}