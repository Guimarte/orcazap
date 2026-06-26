import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class RecentBudgetsHeaderWidget extends StatelessWidget {
  final VoidCallback? onViewAll;

  const RecentBudgetsHeaderWidget({super.key, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Orçamentos recentes',
            style: AppTextStyles.h3.copyWith(fontSize: 16),
          ),
          GestureDetector(
            onTap: onViewAll,
            child: Text(
              'Ver todos',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
