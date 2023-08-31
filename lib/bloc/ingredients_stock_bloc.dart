import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/stock_role_event.dart';
import 'package:pizza_coop/bloc/stock_role_state.dart';
import 'package:pizza_coop/domain/stock_role.dart';

class IngredientsStockBloc extends Bloc<StockRoleEvent, StockRoleState> {
  final StockRole stockRole;

  IngredientsStockBloc({required this.stockRole}) : super(InitialStockRoleState()) {
    on<LoadIngredientsStockRoleEvent>(_onLoadIngredientsStockRoleEvent);
  }

  void _onLoadIngredientsStockRoleEvent(
      LoadIngredientsStockRoleEvent event, Emitter<StockRoleState> emit) {
    emit(LoadingIngredientsStockRoleState());
    emit(LoadedIngredientsStockRoleState(stockRole.listStock()));
  }
}