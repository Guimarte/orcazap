import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/shared/widgets/input_widget.dart';

class LoginFormWidget extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bem-vindo de volta', style: AppTextStyles.h2),
        const SizedBox(height: 6),
        Text(
          'Entre para acessar a sua oficina',
          style: AppTextStyles.bodySecondary.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 28),
        InputWidget(
          labelText: 'E-mail',
          hintText: 'voce@oficina.com.br',
          controller: widget.emailController,
          textInputType: TextInputType.emailAddress,
          prefixIcon: Icons.mail_outline_rounded,
        ),
        const SizedBox(height: 20),
        InputWidget(
          labelText: 'Senha',
          hintText: '••••••••',
          controller: widget.passwordController,
          obscureText: _obscurePassword,
          prefixIcon: Icons.lock_outline_rounded,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 20,
              color: AppColors.textHint,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
      ],
    );
  }
}
