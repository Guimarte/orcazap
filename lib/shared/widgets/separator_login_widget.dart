import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class SeparatorLogingWidget extends StatelessWidget {
  const SeparatorLogingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OU CONTINUE COM',
            style: AppTextStyles.label,
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
