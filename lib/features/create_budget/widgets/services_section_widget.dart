import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/features/create_budget/cubit/create_budget_cubit.dart';
import 'package:orcazap/shared/widgets/section_card_widget.dart';
import 'budget_item_row_widget.dart';
import 'package:orcazap/data/models/budget_item_model.dart';

class ServicesSectionWidget extends StatelessWidget {
  final List<BudgetItemModel> items;
  final CreateBudgetCubit cubit;

  const ServicesSectionWidget({
    super.key,
    required this.items,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      icon: Icons.build_circle_outlined,
      title: 'SERVIÇOS & PEÇAS',
      child: Column(
        children: [
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  const Icon(
                    Icons.build_circle_outlined,
                    size: 32,
                    color: AppColors.textHint,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nenhum item adicionado',
                    style: AppTextStyles.bodySecondary.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Adicione serviços ou peças abaixo',
                    style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return BudgetItemRowWidget(
                  key: ObjectKey(item),
                  index: index,
                  item: item,
                  onRemove: () => cubit.removeItem(index),
                  onDescriptionChanged: (val) => cubit.updateDescription(index, val),
                  onQuantityChanged: (val) => cubit.updateQuantity(index, val),
                  onPriceChanged: (val) => cubit.updateUnitPrice(index, val),
                );
              },
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => cubit.addItem('servico'),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Serviço'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    minimumSize: const Size(0, 44),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => cubit.addItem('peca'),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Peça'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    minimumSize: const Size(0, 44),
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
