import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/shared/widgets/separator_login_widget.dart';

class SocialLoginWidget extends StatelessWidget {
  final VoidCallback? onGooglePressed;
  final VoidCallback? onApplePressed;

  const SocialLoginWidget({
    super.key,
    this.onGooglePressed,
    this.onApplePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SeparatorLogingWidget(),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onGooglePressed,
                icon: Text(
                  'G',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                label: const Text('Google'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onApplePressed,
                icon: const Icon(Icons.apple, size: 22),
                label: const Text('Apple'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
