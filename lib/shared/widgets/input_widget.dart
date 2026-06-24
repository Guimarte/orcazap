import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final TextInputType? textInputType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;

  const InputWidget({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.textInputType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Label acima do campo ──
        if (labelText != null) ...[
          Text(
            labelText!.toUpperCase(),
            style: AppTextStyles.label,
          ),
          const SizedBox(height: 8),
        ],

        // ── Campo de texto ──
        TextFormField(
          keyboardType: textInputType,
          obscureText: obscureText,
          controller: controller,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 20, color: AppColors.textHint)
                : null,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
