import 'package:pizza_coop/domain/customers.dart';
import 'package:pizza_coop/domain/menu.dart';

sealed class WaiterRoleState {}

class InitialWaiterRoleState extends WaiterRoleState {}

class LoadingWaiterRoleState extends WaiterRoleState {}

class LoadedWaiterRoleState extends WaiterRoleState {
  final Customers customers;
  final Menu menu;

  LoadedWaiterRoleState(this.customers, this.menu);
}

class ErrorWaiterRoleState extends WaiterRoleState {
  final String message;

  ErrorWaiterRoleState(this.message);
}