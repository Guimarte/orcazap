import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ── Ícone com glow ──
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.surfaceBorder),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: const Icon(
              Icons.build_rounded,
              color: AppColors.primary,
              size: 34,
            ),
          ),
          const SizedBox(height: 20),

          // ── Nome do App ──
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Orça',
                  style: AppTextStyles.h1.copyWith(fontSize: 28),
                ),
                TextSpan(
                  text: 'Zap',
                  style: AppTextStyles.h1.copyWith(
                    fontSize: 28,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // ── Subtítulo ──
          Text(
            'Gestão de orçamentos para oficinas',
            style: AppTextStyles.bodySecondary.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
