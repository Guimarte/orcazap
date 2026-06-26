import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class TermsCheckboxWidget extends StatefulWidget {
  final ValueChanged<bool>? onChanged;

  const TermsCheckboxWidget({super.key, this.onChanged});

  @override
  State<TermsCheckboxWidget> createState() => _TermsCheckboxWidgetState();
}

class _TermsCheckboxWidgetState extends State<TermsCheckboxWidget> {
  bool _accepted = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: _accepted,
            onChanged: (value) {
              setState(() => _accepted = value ?? false);
              widget.onChanged?.call(_accepted);
            },
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
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => _accepted = !_accepted);
              widget.onChanged?.call(_accepted);
            },
            child: Text.rich(
              TextSpan(
                text: 'Concordo com os ',
                style: AppTextStyles.bodySmall,
                children: [
                  TextSpan(
                    text: 'Termos de uso',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO: abrir Termos de uso
                      },
                  ),
                  const TextSpan(text: ' e a '),
                  TextSpan(
                    text: 'Política de privacidade',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO: abrir Política de privacidade
                      },
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
