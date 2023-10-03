import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/waiter_role/waiter_role_bloc.dart';
import 'package:pizza_coop/domain/customer.dart';
import 'package:pizza_coop/domain/customers.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/menu.dart';
import 'package:pizza_coop/domain/recipe.dart';
import 'package:pizza_coop/domain/waiter_role.dart';
import 'package:pizza_coop/presentation/waiter_role_page_view.dart';

class WaiterRolePage extends StatelessWidget {
  final waiterRole = WaiterRole(
      Menu(recipes: [
        Recipe('Margherita', [
          StockIngredient('flour', 1),
          StockIngredient('tomato sauce', 1),
          StockIngredient('cheese', 1)
        ])
      ]),
      Customers([Customer(0, 'John'), Customer(1, 'Jane')]),
      PreparedIngredients());

  WaiterRolePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => WaiterRoleBloc(waiterRole: waiterRole))
    ], child: const WaiterRolePageView());
  }
}
