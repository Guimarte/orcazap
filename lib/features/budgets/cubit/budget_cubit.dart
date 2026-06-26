import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcazap/data/repositories/budget_repository.dart';
import 'package:orcazap/data/models/budget_model.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  final BudgetRepository _budgetRepository;
  final String _shopId;

  BudgetCubit(this._budgetRepository, this._shopId) : super(BudgetListInitial());

  Future<void> loadBudgets() async {
    emit(BudgetListLoading());
    try {
      final budgets = await _budgetRepository.getAllBudgets(_shopId);
      emit(BudgetListLoaded(
        allBudgets: budgets,
        filteredBudgets: budgets,
        searchQuery: '',
        filterDate: null,
      ));
    } catch (e) {
      emit(BudgetListError('Erro ao carregar orçamentos: $e'));
    }
  }

  void filterBudgets({String? searchQuery, DateTime? filterDate, bool clearDate = false}) {
    final currentState = state;
    if (currentState is! BudgetListLoaded) return;

    final query = searchQuery ?? currentState.searchQuery;
    final date = clearDate ? null : (filterDate ?? currentState.filterDate);

    final filtered = currentState.allBudgets.where((budget) {
      // 1. Filtro por nome do cliente
      final clientName = budget.clientName.toLowerCase();
      final matchesQuery = clientName.contains(query.toLowerCase());

      // 2. Filtro por data
      bool matchesDate = true;
      if (date != null) {
        final createdAt = budget.createdAt;
        matchesDate = createdAt.year == date.year &&
            createdAt.month == date.month &&
            createdAt.day == date.day;
      }

      return matchesQuery && matchesDate;
    }).toList();

    emit(BudgetListLoaded(
      allBudgets: currentState.allBudgets,
      filteredBudgets: filtered,
      searchQuery: query,
      filterDate: date,
    ));
  }
}
