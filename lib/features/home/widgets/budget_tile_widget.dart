import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class BudgetTileWidget extends StatelessWidget {
  final String clientName;
  final String vehicle;
  final String plate;
  final double total;
  final String status;
  final VoidCallback? onTap;

  const BudgetTileWidget({
    super.key,
    required this.clientName,
    required this.vehicle,
    required this.plate,
    required this.total,
    required this.status,
    this.onTap,
  });

  String get _initial => clientName.isNotEmpty ? clientName[0].toUpperCase() : '?';

  @override
  Widget build(BuildContext context) {
    final formattedTotal = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 0,
    ).format(total);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Row(
        children: [
          // ── Avatar ──
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.surfaceBorder),
            ),
            alignment: Alignment.center,
            child: Text(
              _initial,
              style: AppTextStyles.button.copyWith(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // ── Nome + veículo ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clientName,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  '$vehicle · $plate',
                  style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // ── Valor + Status ──
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formattedTotal,
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: StatusHelper.backgroundColor(status),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  StatusHelper.label(status),
                  style: TextStyle(
                    color: StatusHelper.color(status),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}
