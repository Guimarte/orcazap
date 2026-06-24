import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class RememberMeWidget extends StatefulWidget {
  final VoidCallback? onForgotPassword;

  const RememberMeWidget({super.key, this.onForgotPassword});

  @override
  State<RememberMeWidget> createState() => _RememberMeWidgetState();
}

class _RememberMeWidgetState extends State<RememberMeWidget> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => setState(() => _rememberMe = !_rememberMe),
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: _rememberMe,
                  onChanged: (value) =>
                      setState(() => _rememberMe = value ?? false),
                  activeColor: AppColors.primary,
                  checkColor: AppColors.onPrimary,
                  side: const BorderSide(
                    color: AppColors.textHint,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text('Lembrar de mim', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        GestureDetector(
          onTap: widget.onForgotPassword,
          child: Text(
            'Esqueceu a senha?',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
