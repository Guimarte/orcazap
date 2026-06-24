import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/features/login/login_mixin.dart';
import 'package:orcazap/shared/widgets/create_account_widget.dart';
import 'package:orcazap/shared/widgets/login_form_widget.dart';
import 'package:orcazap/shared/widgets/remember_me_widget.dart';
import 'package:orcazap/shared/widgets/social_login_widget.dart';
import 'package:orcazap/shared/widgets/header_login_widget.dart';
import 'package:orcazap/shared/widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderLoginWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.65,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Formulário (email + senha) ──
                      LoginFormWidget(
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                      const SizedBox(height: 16),

                      RememberMeWidget(
                        onForgotPassword: () {
                          // TODO: implementar recuperação de senha
                        },
                      ),
                      const SizedBox(height: 32),

                      PrimaryButton(
                        title: 'Entrar',
                        onPressed: () {
                          // TODO: implementar login
                        },
                      ),
                      const SizedBox(height: 24),

                      SocialLoginWidget(
                        onGooglePressed: () {
                          nativeGoogleSignIn();
                        },
                        onApplePressed: () {
                          // TODO: login com Apple
                        },
                      ),
                      const SizedBox(height: 32),

                      CreateAccountWidget(
                        onCreateAccount: () {
                          // TODO: navegar para cadastro
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
