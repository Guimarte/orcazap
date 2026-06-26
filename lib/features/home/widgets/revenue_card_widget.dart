import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class RevenueCardWidget extends StatelessWidget {
  final double weekRevenue;
  final int weekOrdersCount;

  const RevenueCardWidget({
    super.key,
    required this.weekRevenue,
    required this.weekOrdersCount,
  });

  @override
  Widget build(BuildContext context) {
    final formattedRevenue = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 0,
    ).format(weekRevenue);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surface,
              AppColors.success.withValues(alpha: 0.08),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.surfaceBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Label + ícone ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'FATURAMENTO ESTIMADO',
                  style: AppTextStyles.label.copyWith(
                    letterSpacing: 1.0,
                    fontSize: 11,
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.trending_up_rounded,
                    color: AppColors.success,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Valor + badge ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formattedRevenue,
                  style: AppTextStyles.currency.copyWith(fontSize: 28),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '+18%',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // ── Subtexto ──
            Text(
              'esta semana · $weekOrdersCount ordens',
              style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
