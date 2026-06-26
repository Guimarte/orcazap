import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class BudgetSummaryWidget extends StatelessWidget {
  final double subtotal;
  final TextEditingController discountController;
  final ValueChanged<double> onDiscountChanged;

  const BudgetSummaryWidget({
    super.key,
    required this.subtotal,
    required this.discountController,
    required this.onDiscountChanged,
  });

  @override
  Widget build(BuildContext context) {
    final discount = double.tryParse(discountController.text.replaceAll(',', '.')) ?? 0.0;
    final total = (subtotal - discount) > 0 ? (subtotal - discount) : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.surfaceBorder, width: 1.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal:',
                  style: AppTextStyles.bodySecondary,
                ),
                Text(
                  'R\$ ${subtotal.toStringAsFixed(2)}',
                  style: AppTextStyles.body,
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Desconto (Campo)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Desconto:',
                  style: AppTextStyles.bodySecondary,
                ),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: TextFormField(
                    controller: discountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.end,
                    style: AppTextStyles.body.copyWith(color: AppColors.error),
                    onChanged: (val) {
                      final disc = double.tryParse(val.replaceAll(',', '.')) ?? 0.0;
                      onDiscountChanged(disc);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      fillColor: AppColors.surfaceLight,
                      prefixText: 'R\$ ',
                      prefixStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.surfaceBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.surfaceBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL:',
                  style: AppTextStyles.h3.copyWith(fontSize: 16),
                ),
                Text(
                  'R\$ ${total.toStringAsFixed(2)}',
                  style: AppTextStyles.currency,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
