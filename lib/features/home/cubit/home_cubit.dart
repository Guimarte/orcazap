import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcazap/data/repositories/budget_repository.dart';
import 'package:orcazap/data/repositories/shop_repository.dart';
import 'package:orcazap/data/models/shop_model.dart';
import 'package:orcazap/data/models/budget_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ShopRepository _shopRepository;
  final BudgetRepository _budgetRepository;

  HomeCubit(this._shopRepository, this._budgetRepository)
      : super(HomeInitial());

  /// Carrega todos os dados do dashboard em paralelo.
  Future<void> loadDashboard() async {
    emit(HomeLoading());
    try {
      // 1. Busca a oficina do usuário
      final shop = await _shopRepository.getMyShop();
      if (shop == null) {
        emit(HomeError('Oficina não encontrada.'));
        return;
      }

      final shopId = shop.id;

      // 2. Busca stats e orçamentos recentes em paralelo
      final results = await Future.wait([
        _budgetRepository.getBudgetStats(shopId),
        _budgetRepository.getRecentBudgets(shopId),
      ]);

      final stats = results[0] as Map<String, dynamic>;
      final recentBudgets = results[1] as List<BudgetModel>;

      if (isClosed) return;

      emit(HomeLoaded(
        shop: shop,
        todayCount: stats['todayCount'] as int,
        approvedCount: stats['approvedCount'] as int,
        pendingCount: stats['pendingCount'] as int,
        weekRevenue: stats['weekRevenue'] as double,
        weekOrdersCount: stats['weekOrdersCount'] as int,
        recentBudgets: recentBudgets,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(HomeError('Erro ao carregar dashboard: $e'));
    }
  }
}
