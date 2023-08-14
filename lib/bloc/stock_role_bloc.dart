import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/stock_role_event.dart';
import 'package:pizza_coop/bloc/stock_role_state.dart';

class StockRoleBloc extends Bloc<StockRoleEvent, StockRoleState> {
  StockRoleBloc() : super(InitialStockRoleState());
}