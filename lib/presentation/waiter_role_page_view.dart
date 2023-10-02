import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/waiter_role/waiter_role_bloc.dart';
import 'package:pizza_coop/bloc/waiter_role/waiter_role_event.dart';
import 'package:pizza_coop/bloc/waiter_role/waiter_role_state.dart';
import 'package:pizza_coop/domain/customers.dart';

class WaiterRolePageView extends StatelessWidget {
  const WaiterRolePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waiter Role'),
      ),
      body: BlocBuilder<WaiterRoleBloc, WaiterRoleState>(
        builder: (context, state) {
          if (state is InitialWaiterRoleState) {
            return const _InitialWaiterRoleView();
          } else if (state is LoadingWaiterRoleState) {
            return const _LoadingWaiterRoleView();
          } else if (state is LoadedWaiterRoleState) {
            return _LoadedWaiterRoleView(customers: state.customers);
          } else if (state is ErrorWaiterRoleState) {
            return _ErrorWaiterRoleView(message: state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _ErrorWaiterRoleView extends StatelessWidget {
  final String message;

  const _ErrorWaiterRoleView({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}

class _LoadedWaiterRoleView extends StatelessWidget {
  final Customers customers;

  const _LoadedWaiterRoleView({Key? key, required this.customers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: customers.customers.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(customers.customers[index].name),
        );
      },
    );
  }
}

class _LoadingWaiterRoleView extends StatelessWidget {
  const _LoadingWaiterRoleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _InitialWaiterRoleView extends StatelessWidget {
  const _InitialWaiterRoleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WaiterRoleBloc>(context).add(LoadWaiterRoleEvent());
    return const Center(child: Text('InitialWaiterRoleView'));
  }
}
