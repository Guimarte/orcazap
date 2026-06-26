import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class CreateBudgetAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onSave;

  const CreateBudgetAppBarWidget({
    super.key,
    this.title = 'Novo orçamento',
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ORÇAMENTO',
            style: AppTextStyles.label.copyWith(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.w700),
          ),
          Text(
            title,
            style: AppTextStyles.h2.copyWith(fontSize: 18),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.check_rounded, color: AppColors.primary, size: 28),
          onPressed: onSave,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
