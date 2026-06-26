import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';

class RegisterHeaderWidget extends StatelessWidget {
  const RegisterHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Criar oficina', style: AppTextStyles.h2),
        const SizedBox(height: 6),
        Text(
          'Preencha os dados abaixo para começar',
          style: AppTextStyles.bodySecondary.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
