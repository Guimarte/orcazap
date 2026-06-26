import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/features/home/cubit/home_cubit.dart';
import 'package:orcazap/features/home/widgets/home_header_widget.dart';
import 'package:orcazap/features/home/widgets/revenue_card_widget.dart';
import 'package:orcazap/features/home/widgets/stats_row_widget.dart';
import 'package:orcazap/features/home/widgets/recent_budgets_header_widget.dart';
import 'package:orcazap/features/home/widgets/budget_tile_widget.dart';
import 'package:orcazap/features/home/widgets/new_budget_fab_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading || state is HomeInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is HomeError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: AppTextStyles.bodySecondary,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton(
                    onPressed: () =>
                        context.read<HomeCubit>().loadDashboard(),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            ),
          );
        }

        final loaded = state as HomeLoaded;
        final shop = loaded.shop;
        final budgets = loaded.recentBudgets;

        return Stack(
          children: [
            // ── Conteúdo rolável ──
            RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () =>
                  context.read<HomeCubit>().loadDashboard(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 80),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Header ──
                      HomeHeaderWidget(
                        ownerName: shop.ownerName,
                        shopName: shop.shopName,
                      ),
                      const SizedBox(height: 16),

                      // ── Card de faturamento ──
                      RevenueCardWidget(
                        weekRevenue: loaded.weekRevenue,
                        weekOrdersCount: loaded.weekOrdersCount,
                      ),
                      const SizedBox(height: 16),

                      // ── Stats (hoje, aprovados, pendentes) ──
                      StatsRowWidget(
                        todayCount: loaded.todayCount,
                        approvedCount: loaded.approvedCount,
                        pendingCount: loaded.pendingCount,
                      ),
                      const SizedBox(height: 24),

                      // ── Orçamentos recentes ──
                      RecentBudgetsHeaderWidget(
                        onViewAll: () {
                          // TODO: navegar para lista completa
                        },
                      ),
                      const SizedBox(height: 12),

                      // ── Lista de orçamentos ──
                      if (budgets.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 32,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.description_outlined,
                                  size: 40,
                                  color: AppColors.textHint,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Nenhum orçamento ainda',
                                  style: AppTextStyles.bodySecondary,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Crie seu primeiro orçamento!',
                                  style: AppTextStyles.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ...budgets.map(
                          (budget) => BudgetTileWidget(
                            clientName: budget.clientName,
                            vehicle: budget.vehicle,
                            plate: budget.plate,
                            total: budget.total,
                            status: budget.status,
                            onTap: () async {
                              final result = await context.push<bool>(
                                '/new_budget?shopId=${shop.id}&budgetId=${budget.id}',
                              );
                              if (result == true && context.mounted) {
                                context.read<HomeCubit>().loadDashboard();
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // ── FAB "Novo orçamento" fixo na parte inferior ──
            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: NewBudgetFabWidget(
                onPressed: () async {
                  final result = await context.push<bool>('/new_budget?shopId=${shop.id}');
                  if (result == true && context.mounted) {
                    context.read<HomeCubit>().loadDashboard();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
