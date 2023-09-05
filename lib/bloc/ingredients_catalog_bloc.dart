import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_event.dart';
import 'package:pizza_coop/bloc/ingredients_catalog_state.dart';
import 'package:pizza_coop/domain/stock_role.dart';

class IngredientsCatalogBloc
    extends Bloc<IngredientsCatalogEvent, IngredientsCatalogState> {
  final StockRole stockRole;

  IngredientsCatalogBloc({required this.stockRole})
      : super(InitialIngredientsCatalogState()) {
    on<LoadIngredientsCatalogEvent>(_onLoadIngredientsCatalogEvent);
  }

  void _onLoadIngredientsCatalogEvent(
    LoadIngredientsCatalogEvent event,
    Emitter<IngredientsCatalogState> emit,
  ) {
    emit(LoadingIngredientsCatalogState());
    emit(LoadedIngredientsCatalogState(stockRole.listCatalog()));
  }
}
