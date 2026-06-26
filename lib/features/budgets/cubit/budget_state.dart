part of 'budget_cubit.dart';

sealed class BudgetState {}

final class BudgetListInitial extends BudgetState {}

final class BudgetListLoading extends BudgetState {}

final class BudgetListLoaded extends BudgetState {
  final List<BudgetModel> allBudgets;
  final List<BudgetModel> filteredBudgets;
  final String searchQuery;
  final DateTime? filterDate;

  BudgetListLoaded({
    required this.allBudgets,
    required this.filteredBudgets,
    required this.searchQuery,
    this.filterDate,
  });
}

final class BudgetListError extends BudgetState {
  final String message;
  BudgetListError(this.message);
}
