import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/features/budgets/cubit/budget_cubit.dart';
import 'package:orcazap/features/home/cubit/home_cubit.dart';
import 'package:orcazap/features/home/widgets/budget_tile_widget.dart';
import 'package:orcazap/data/models/shop_model.dart';

class BudgetsPage extends StatefulWidget {
  const BudgetsPage({super.key});

  @override
  State<BudgetsPage> createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Busca dados da oficina do HomeCubit
    final homeState = context.read<HomeCubit>().state;
    ShopModel? shop;
    if (homeState is HomeLoaded) {
      shop = homeState.shop;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orçamentos'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: BlocBuilder<BudgetCubit, BudgetState>(
        builder: (context, state) {
          if (state is BudgetListInitial || state is BudgetListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is BudgetListError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline_rounded, size: 48, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(state.message, style: AppTextStyles.bodySecondary),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => context.read<BudgetCubit>().loadBudgets(),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          final loaded = state as BudgetListLoaded;
          final budgets = loaded.filteredBudgets;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── CAMPOS DE BUSCA E FILTROS ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          context.read<BudgetCubit>().filterBudgets(searchQuery: val);
                        },
                        style: AppTextStyles.body,
                        decoration: InputDecoration(
                          hintText: 'Buscar por cliente...',
                          prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textHint, size: 20),
                          fillColor: AppColors.surface,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.surfaceBorder),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.surfaceBorder),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Calendário
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.surfaceBorder),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.calendar_today_rounded,
                          color: loaded.filterDate != null ? AppColors.primary : AppColors.textSecondary,
                          size: 20,
                        ),
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: loaded.filterDate ?? DateTime.now(),
                            firstDate: DateTime(2025),
                            lastDate: DateTime(2030),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.dark(
                                    primary: AppColors.primary,
                                    onPrimary: AppColors.onPrimary,
                                    surface: AppColors.surface,
                                    onSurface: AppColors.textPrimary,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (selectedDate != null && context.mounted) {
                            context.read<BudgetCubit>().filterBudgets(filterDate: selectedDate);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // ── CHIP DE FILTRO DE DATA ATIVO ──
              if (loaded.filterDate != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Chip(
                    label: Text(
                      'Data: ${DateFormat('dd/MM/yyyy').format(loaded.filterDate!)}',
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                    backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                    deleteIcon: const Icon(Icons.close_rounded, size: 16, color: AppColors.primary),
                    onDeleted: () {
                      context.read<BudgetCubit>().filterBudgets(clearDate: true);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: AppColors.primary, width: 0.5),
                    ),
                  ),
                ),

              const SizedBox(height: 8),

              // ── LISTA DE ORÇAMENTOS ──
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () => context.read<BudgetCubit>().loadBudgets(),
                  child: budgets.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                            const Center(
                              child: Column(
                                children: [
                                  Icon(Icons.description_outlined, size: 48, color: AppColors.textHint),
                                  SizedBox(height: 12),
                                  Text('Nenhum orçamento encontrado', style: AppTextStyles.bodySecondary),
                                ],
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: budgets.length,
                          itemBuilder: (context, index) {
                            final budget = budgets[index];
                            return BudgetTileWidget(
                              key: ValueKey(budget.id),
                              clientName: budget.clientName,
                              vehicle: budget.vehicle,
                              plate: budget.plate,
                              total: budget.total,
                              status: budget.status,
                              onTap: () async {
                                final result = await context.push<bool>(
                                  '/new_budget?shopId=${shop?.id}&budgetId=${budget.id}',
                                );
                                if (result == true && context.mounted) {
                                  // Atualiza lista local
                                  context.read<BudgetCubit>().loadBudgets();
                                  // Atualiza dashboard em background
                                  context.read<HomeCubit>().loadDashboard();
                                }
                              },
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
