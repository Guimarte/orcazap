import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

/// Card de seção reutilizável com ícone + título.
/// Usado nas seções: Cliente, Veículo, Serviços & Peças, Detalhes.
class SectionCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const SectionCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header da seção ──
          Row(
            children: [
              Icon(icon, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTextStyles.h3.copyWith(fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}
