import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class LoginRedirectWidget extends StatelessWidget {
  final VoidCallback? onLogin;

  const LoginRedirectWidget({super.key, this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onLogin,
        child: Text.rich(
          TextSpan(
            text: 'Já tem uma conta? ',
            style: AppTextStyles.bodySmall,
            children: [
              TextSpan(
                text: 'Entrar',
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
