import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/waiter_role/waiter_role_event.dart';
import 'package:pizza_coop/bloc/waiter_role/waiter_role_state.dart';
import 'package:pizza_coop/domain/waiter_role.dart';

class WaiterRoleBloc extends Bloc<WaiterRoleEvent, WaiterRoleState> {
  final WaiterRole waiterRole;

  WaiterRoleBloc({required this.waiterRole}) : super(InitialWaiterRoleState()) {
    on<LoadWaiterRoleEvent>(_onLoadWaiterRoleEvent);
  }

  void _onLoadWaiterRoleEvent(LoadWaiterRoleEvent event, Emitter<WaiterRoleState> emit) {
    emit(LoadingWaiterRoleState());
    emit(LoadedWaiterRoleState(waiterRole.customers, waiterRole.menu));
  }
}