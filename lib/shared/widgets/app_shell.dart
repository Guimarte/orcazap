import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/data/repositories/budget_repository.dart';
import 'package:orcazap/features/home/cubit/home_cubit.dart';
import 'package:orcazap/features/budgets/budgets_page.dart';
import 'package:orcazap/features/budgets/cubit/budget_cubit.dart';
import 'package:orcazap/features/settings/settings_page.dart';

class AppShell extends StatefulWidget {
  /// O conteúdo da aba Dashboard (index 0).
  final Widget dashboard;
  final BudgetRepository budgetRepository;

  const AppShell({
    super.key,
    required this.dashboard,
    required this.budgetRepository,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // 0 — Dashboard
          widget.dashboard,

          // 1 — Clientes (placeholder)
          const _PlaceholderTab(
            icon: Icons.people_outline_rounded,
            label: 'Clientes',
          ),

          // 2 — Orçamentos
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, homeState) {
              if (homeState is HomeLoaded) {
                final shopId = homeState.shop.id;
                return BlocProvider(
                  create: (_) => BudgetCubit(widget.budgetRepository, shopId)..loadBudgets(),
                  child: const BudgetsPage(),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),

          // 3 — Ajustes
          const SettingsPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.surfaceBorder, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline_rounded),
              label: 'Clientes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined),
              label: 'Orçamentos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Ajustes',
            ),
          ],
        ),
      ),
    );
  }
}

/// Placeholder para abas ainda não implementadas.
class _PlaceholderTab extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PlaceholderTab({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: AppColors.textHint),
          const SizedBox(height: 12),
          Text(
            label,
            style: AppTextStyles.h3.copyWith(color: AppColors.textHint),
          ),
          const SizedBox(height: 4),
          Text('Em breve', style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}
