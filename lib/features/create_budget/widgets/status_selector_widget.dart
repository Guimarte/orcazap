import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/shared/widgets/section_card_widget.dart';

class StatusSelectorWidget extends StatelessWidget {
  final String currentStatus;
  final ValueChanged<String> onStatusChanged;

  const StatusSelectorWidget({
    super.key,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      icon: Icons.toggle_on_outlined,
      title: 'STATUS DO ORÇAMENTO',
      child: Row(
        children: [
          _buildStatusOption(
            context,
            status: 'pendente',
            label: 'Pendente',
            activeColor: AppColors.warning,
            activeBgColor: AppColors.warningBg,
          ),
          const SizedBox(width: 8),
          _buildStatusOption(
            context,
            status: 'aprovado',
            label: 'Aprovado',
            activeColor: AppColors.success,
            activeBgColor: AppColors.successBg,
          ),
          const SizedBox(width: 8),
          _buildStatusOption(
            context,
            status: 'recusado',
            label: 'Negado',
            activeColor: AppColors.error,
            activeBgColor: AppColors.errorBg,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOption(
    BuildContext context, {
    required String status,
    required String label,
    required Color activeColor,
    required Color activeBgColor,
  }) {
    final isActive = currentStatus == status;

    return Expanded(
      child: GestureDetector(
        onTap: () => onStatusChanged(status),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? activeBgColor : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? activeColor : AppColors.surfaceBorder,
              width: isActive ? 2.0 : 1.0,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.body.copyWith(
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive ? activeColor : AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
