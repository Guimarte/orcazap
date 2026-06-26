class BudgetItemModel {
  final String? id;
  final String? budgetId;
  String description;
  int quantity;
  double unitPrice;
  final String type; // 'servico' ou 'peca'

  BudgetItemModel({
    this.id,
    this.budgetId,
    this.description = '',
    this.quantity = 1,
    this.unitPrice = 0.0,
    required this.type,
  });

  double get total => quantity * unitPrice;

  factory BudgetItemModel.fromMap(Map<String, dynamic> map) {
    return BudgetItemModel(
      id: map['id'] as String?,
      budgetId: map['budget_id'] as String?,
      description: map['description'] as String? ?? '',
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      unitPrice: (map['unit_price'] as num?)?.toDouble() ?? 0.0,
      type: map['type'] as String? ?? 'servico',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (budgetId != null) 'budget_id': budgetId,
      'description': description,
      'quantity': quantity,
      'unit_price': unitPrice,
    };
  }
}
