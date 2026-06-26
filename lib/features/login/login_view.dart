import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/features/login/cubit/login_cubit.dart';
import 'package:orcazap/features/login/login_mixin.dart';
import 'package:orcazap/shared/widgets/create_account_widget.dart';
import 'package:orcazap/shared/widgets/login_form_widget.dart';
import 'package:orcazap/shared/widgets/remember_me_widget.dart';
import 'package:orcazap/shared/widgets/social_login_widget.dart';
import 'package:orcazap/shared/widgets/header_login_widget.dart';
import 'package:orcazap/shared/widgets/primary_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessNeedsShop) {
          context.push('/register?isGoogle=true');
        } else if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
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
                    child: BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        final isLoading = state is LoginLoading;
                        return Column(
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
                              title: isLoading ? 'Entrando...' : 'Entrar',
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      context.read<LoginCubit>().signInWithEmail(
                                            emailController.text.trim(),
                                            passwordController.text,
                                          );
                                    },
                            ),
                            const SizedBox(height: 24),

                            SocialLoginWidget(
                              onGooglePressed: isLoading
                                  ? null
                                  : () {
                                      context
                                          .read<LoginCubit>()
                                          .signInWithGoogle();
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
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
