import 'package:pizza_coop/bloc/stock_role_bloc.dart';
import 'package:pizza_coop/bloc/stock_role_event.dart';
import 'package:pizza_coop/bloc/stock_role_state.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/stock_role.dart';
import 'package:pizza_coop/domain/wallet.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  test('StockRoleBloc initializes with correct initial state', () {
    final stockCatalog = IngredientsCatalog();
    final stock = IngredientsStock();
    final wallet = Wallet();
    final stockRole =
        StockRole(catalog: stockCatalog, stock: stock, wallet: wallet);
    final stockRoleBloc = StockRoleBloc(stockRole: stockRole);
    expect(stockRoleBloc.state.runtimeType, InitialStockRoleState);
    stockRoleBloc.close();
  });

  blocTest<StockRoleBloc, StockRoleState>(
    'StockRoleBloc emits LoadingIngredientsStockRoleState when LoadIngredientsStockRoleEvent is added',
    build: () {
      final stockCatalog = IngredientsCatalog();
      final stock = IngredientsStock();
      final wallet = Wallet();
      final stockRole =
          StockRole(catalog: stockCatalog, stock: stock, wallet: wallet);
      return StockRoleBloc(stockRole: stockRole);
    },
    act: (bloc) => bloc.add(LoadIngredientsStockRoleEvent()),
    expect: () => [
      isA<LoadingIngredientsStockRoleState>(),
      isA<LoadedIngredientsStockRoleState>()
    ],
  );

  blocTest<StockRoleBloc, StockRoleState>(
    'StockRoleBloc emits LoadedIngredientsStockRoleState with Ingredients when LoadIngredientsStockRoleEvent is added',
    build: () {
      final stockCatalog = IngredientsCatalog();
      final stock = IngredientsStock(ingredients: [
        StockIngredient('Flour', 10),
        StockIngredient('Tomato', 10)
      ]);
      final wallet = Wallet();
      final stockRole =
          StockRole(catalog: stockCatalog, stock: stock, wallet: wallet);
      return StockRoleBloc(stockRole: stockRole);
    },
    act: (bloc) => bloc.add(LoadIngredientsStockRoleEvent()),
    expect: () => [
      isA<LoadingIngredientsStockRoleState>(),
      predicate<LoadedIngredientsStockRoleState>((state) {
        return state.ingredientStocks.length == 2;
      })
    ],
  );
}