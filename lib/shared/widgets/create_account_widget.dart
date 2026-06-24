import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class CreateAccountWidget extends StatelessWidget {
  final VoidCallback? onCreateAccount;

  const CreateAccountWidget({super.key, this.onCreateAccount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onCreateAccount,
        child: Text.rich(
          TextSpan(
            text: 'Ainda não tem conta? ',
            style: AppTextStyles.bodySmall,
            children: [
              TextSpan(
                text: 'Criar oficina',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
