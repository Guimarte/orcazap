part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  /// Dados da oficina
  final ShopModel shop;

  /// Estatísticas do dashboard
  final int todayCount;
  final int approvedCount;
  final int pendingCount;
  final double weekRevenue;
  final int weekOrdersCount;

  /// Orçamentos recentes
  final List<BudgetModel> recentBudgets;

  HomeLoaded({
    required this.shop,
    required this.todayCount,
    required this.approvedCount,
    required this.pendingCount,
    required this.weekRevenue,
    required this.weekOrdersCount,
    required this.recentBudgets,
  });
}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
