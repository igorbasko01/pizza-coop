import 'package:pizza_coop/bloc/ingredients_catalog_bloc.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_event.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_state.dart';
import 'package:pizza_coop/domain/ingredients/ingredient.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_catalog.dart';
import 'package:pizza_coop/domain/ingredients/ingredients_stock.dart';
import 'package:pizza_coop/domain/stock_role.dart';
import 'package:pizza_coop/domain/wallet.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

void main() {
  test('IngredientsCatalogBloc initializes with correct initial state', () {
    final stockCatalog = IngredientsCatalog();
    final stock = IngredientsStock();
    final wallet = Wallet();
    final stockRole =
        StockRole(catalog: stockCatalog, stock: stock, wallet: wallet);
    final catalogBloc = IngredientsCatalogBloc(stockRole: stockRole);
    expect(catalogBloc.state.runtimeType, InitialIngredientsCatalogState);
    catalogBloc.close();
  });

  blocTest<IngredientsCatalogBloc, IngredientsCatalogState>(
    'IngredientsCatalogBloc emits LoadingIngredientsCatalogState when LoadIngredientsCatalogEvent is added',
    build: () {
      final stockCatalog = IngredientsCatalog();
      final stock = IngredientsStock();
      final wallet = Wallet();
      final stockRole =
          StockRole(catalog: stockCatalog, stock: stock, wallet: wallet);
      return IngredientsCatalogBloc(stockRole: stockRole);
    },
    act: (bloc) => bloc.add(LoadIngredientsCatalogEvent()),
    expect: () => [
      isA<LoadingIngredientsCatalogState>(),
      isA<LoadedIngredientsCatalogState>()
    ],
  );

  blocTest<IngredientsCatalogBloc, IngredientsCatalogState>(
    'IngredientsCatalogBloc emits LoadedIngredientsCatalogState with Ingredients when LoadIngredientsCatalogEvent is added',
    build: () {
      final stockCatalog = IngredientsCatalog(ingredients: [
        PurchasableIngredient('Flour', 5),
        PurchasableIngredient('Tomato', 10)
      ]);
      final stock = IngredientsStock();
      final wallet = Wallet();
      final stockRole =
          StockRole(catalog: stockCatalog, stock: stock, wallet: wallet);
      return IngredientsCatalogBloc(stockRole: stockRole);
    },
    act: (bloc) => bloc.add(LoadIngredientsCatalogEvent()),
    expect: () => [
      isA<LoadingIngredientsCatalogState>(),
      predicate<LoadedIngredientsCatalogState>((state) {
        return state.ingredients.length == 2;
      })
    ],
  );

  blocTest<IngredientsCatalogBloc, IngredientsCatalogState>(
    'IngredientsCatalogBloc emits LoadedIngredientsCatalogState with Ingredients when BuyIngredientsCatalogEvent is added',
    build: () {
      final stockCatalog = IngredientsCatalog(ingredients: [
        PurchasableIngredient('Flour', 5),
        PurchasableIngredient('Tomato', 10)
      ]);
      final stock =
          IngredientsStock(ingredients: [StockIngredient('Flour', 10)]);
      final wallet = Wallet(balance: 20);
      final stockRole =
          StockRole(catalog: stockCatalog, stock: stock, wallet: wallet);
      return IngredientsCatalogBloc(stockRole: stockRole);
    },
    act: (bloc) => bloc
        .add(BuyIngredientsCatalogEvent(PurchasableIngredient('Flour', 5), 1)),
    verify: (bloc) {
      final stockIngredient = bloc.stockRole.stock.ingredients.firstWhere(
          (element) => element.name == 'Flour',
          orElse: () => throw Exception('Ingredient not found'));
      expect(bloc.stockRole.wallet.balance, 15);
      expect(stockIngredient.amount, 11);
    },
  );
}
