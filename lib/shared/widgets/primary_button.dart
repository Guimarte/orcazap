import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: AppTextStyles.button.copyWith(
            color: AppColors.onPrimary,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
