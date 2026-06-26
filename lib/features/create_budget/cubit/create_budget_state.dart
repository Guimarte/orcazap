part of 'create_budget_cubit.dart';

// ─────────────────────────────────────────────
// States
// ─────────────────────────────────────────────

sealed class CreateBudgetState {
  final List<BudgetItemModel> items;
  const CreateBudgetState(this.items);

  double get subtotal =>
      items.fold(0.0, (sum, item) => sum + item.total);
}

final class CreateBudgetLoading extends CreateBudgetState {
  const CreateBudgetLoading() : super(const []);
}

final class CreateBudgetEditing extends CreateBudgetState {
  const CreateBudgetEditing(super.items);
}

final class CreateBudgetSaving extends CreateBudgetState {
  const CreateBudgetSaving(super.items);
}

final class CreateBudgetSuccess extends CreateBudgetState {
  final BudgetModel budget;
  const CreateBudgetSuccess(this.budget) : super(const []);
}

final class CreateBudgetError extends CreateBudgetState {
  final String message;
  const CreateBudgetError(super.items, this.message);
}
