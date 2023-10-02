import 'package:pizza_coop/domain/customers.dart';

sealed class WaiterRoleState {}

class InitialWaiterRoleState extends WaiterRoleState {}

class LoadingWaiterRoleState extends WaiterRoleState {}

class LoadedWaiterRoleState extends WaiterRoleState {
  final Customers customers;

  LoadedWaiterRoleState(this.customers);
}

class ErrorWaiterRoleState extends WaiterRoleState {
  final String message;

  ErrorWaiterRoleState(this.message);
}