import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class NewBudgetFabWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const NewBudgetFabWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add_rounded, size: 20),
        label: Text(
          'Novo orçamento',
          style: AppTextStyles.button.copyWith(
            color: AppColors.onPrimary,
            fontSize: 15,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 4,
          shadowColor: AppColors.primary.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
