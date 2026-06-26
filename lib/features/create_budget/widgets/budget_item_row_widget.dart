import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/data/models/budget_item_model.dart';

class BudgetItemRowWidget extends StatelessWidget {
  final int index;
  final BudgetItemModel item;
  final VoidCallback onRemove;
  final ValueChanged<String> onDescriptionChanged;
  final ValueChanged<int> onQuantityChanged;
  final ValueChanged<double> onPriceChanged;

  const BudgetItemRowWidget({
    super.key,
    required this.index,
    required this.item,
    required this.onRemove,
    required this.onDescriptionChanged,
    required this.onQuantityChanged,
    required this.onPriceChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isService = item.type == 'servico';
    final badgeColor = isService ? AppColors.primary : AppColors.error;
    final badgeText = isService ? 'SERVIÇO' : 'PEÇA';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badgeText,
                  style: AppTextStyles.label.copyWith(
                    color: badgeColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 20),
                onPressed: onRemove,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Descrição do item
          TextFormField(
            initialValue: item.description,
            onChanged: onDescriptionChanged,
            style: AppTextStyles.body,
            decoration: const InputDecoration(
              labelText: 'DESCRIÇÃO',
              hintText: 'Ex: Troca de óleo',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Qtd
              Expanded(
                flex: 2,
                child: TextFormField(
                  initialValue: item.quantity.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    final qty = int.tryParse(val) ?? 1;
                    onQuantityChanged(qty);
                  },
                  style: AppTextStyles.body,
                  decoration: const InputDecoration(
                    labelText: 'QTD',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Preço Unitário
              Expanded(
                flex: 3,
                child: TextFormField(
                  initialValue: item.unitPrice == 0 ? '' : item.unitPrice.toStringAsFixed(2),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (val) {
                    final price = double.tryParse(val.replaceAll(',', '.')) ?? 0.0;
                    onPriceChanged(price);
                  },
                  style: AppTextStyles.body,
                  decoration: const InputDecoration(
                    labelText: 'PREÇO UNITÁRIO',
                    prefixText: 'R\$ ',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Total
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'TOTAL',
                      style: AppTextStyles.label.copyWith(fontSize: 10),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'R\$ ${item.total.toStringAsFixed(2)}',
                      style: AppTextStyles.h3.copyWith(fontSize: 14, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
