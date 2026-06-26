import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/features/register/cubit/register_cubit.dart';
import 'package:orcazap/features/register/register_mixin.dart';
import 'package:orcazap/features/register/widgets/register_header_widget.dart';
import 'package:orcazap/features/register/widgets/shop_name_input_widget.dart';
import 'package:orcazap/features/register/widgets/owner_name_input_widget.dart';
import 'package:orcazap/features/register/widgets/email_input_widget.dart';
import 'package:orcazap/features/register/widgets/phone_city_input_widget.dart';
import 'package:orcazap/features/register/widgets/password_input_widget.dart';
import 'package:orcazap/features/register/widgets/terms_checkbox_widget.dart';
import 'package:orcazap/features/register/widgets/login_redirect_widget.dart';
import 'package:orcazap/shared/widgets/header_login_widget.dart';
import 'package:orcazap/shared/widgets/primary_button.dart';

class RegisterView extends StatefulWidget {
  final bool isGoogleSignUp;

  const RegisterView({super.key, required this.isGoogleSignUp});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          context.go('/home');
        } else if (state is RegisterError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // ── Header com logo OrcaZap ──
              const HeaderLoginWidget(),

              // ── Card principal ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                    child: BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        final isLoading = state is RegisterLoading;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Título ──
                            const RegisterHeaderWidget(),
                            const SizedBox(height: 28),

                            // ── Nome da Oficina ──
                            ShopNameInputWidget(
                              controller: shopNameController,
                            ),
                            const SizedBox(height: 20),

                            // ── Seu Nome ──
                            OwnerNameInputWidget(
                              controller: ownerNameController,
                            ),
                            const SizedBox(height: 20),

                            // ── E-mail (escondido se Google) ──
                            if (!widget.isGoogleSignUp) ...[
                              EmailInputWidget(
                                controller: emailController,
                              ),
                              const SizedBox(height: 20),
                            ],

                            // ── Telefone + Cidade ──
                            PhoneCityInputWidget(
                              phoneController: phoneController,
                              cityController: cityController,
                            ),
                            const SizedBox(height: 20),

                            // ── Senha (escondido se Google) ──
                            if (!widget.isGoogleSignUp) ...[
                              PasswordInputWidget(
                                controller: passwordController,
                              ),
                              const SizedBox(height: 20),
                            ],

                            // ── Termos ──
                            TermsCheckboxWidget(
                              onChanged: (value) {
                                setState(() => termsAccepted = value);
                              },
                            ),
                            const SizedBox(height: 24),

                            // ── Botão criar oficina ──
                            PrimaryButton(
                              title: isLoading
                                  ? 'Criando...'
                                  : 'Criar minha oficina',
                              onPressed: (isLoading || !termsAccepted)
                                  ? null
                                  : () {
                                      context.read<RegisterCubit>().register(
                                            shopName:
                                                shopNameController.text.trim(),
                                            ownerName:
                                                ownerNameController.text.trim(),
                                            phone: phoneController.text.trim(),
                                            city: cityController.text.trim(),
                                            email: widget.isGoogleSignUp
                                                ? null
                                                : emailController.text.trim(),
                                            password: widget.isGoogleSignUp
                                                ? null
                                                : passwordController.text,
                                            isGoogleSignUp:
                                                widget.isGoogleSignUp,
                                          );
                                    },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Link para login ──
              LoginRedirectWidget(
                onLogin: () => context.go('/'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
