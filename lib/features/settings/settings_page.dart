import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/features/home/cubit/auth_cubit.dart';
import 'package:orcazap/features/home/cubit/home_cubit.dart';
import 'package:orcazap/data/models/shop_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Recupera dados da oficina do HomeCubit
    final homeState = context.read<HomeCubit>().state;
    ShopModel? shop;
    if (homeState is HomeLoaded) {
      shop = homeState.shop;
    }

    final shopName = shop?.shopName ?? 'Minha Oficina';
    final ownerName = shop?.ownerName ?? 'Responsável';
    final phone = shop?.phone ?? 'Contato';
    final city = shop?.city ?? 'Cidade';

    final initial = shopName.isNotEmpty ? shopName[0].toUpperCase() : '?';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ── PERFIL / CABEÇALHO ──
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.surfaceBorder),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary, width: 1.5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      initial,
                      style: AppTextStyles.h2.copyWith(color: AppColors.primary, fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shopName,
                          style: AppTextStyles.h3.copyWith(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ownerName,
                          style: AppTextStyles.bodySecondary.copyWith(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$city · $phone',
                          style: AppTextStyles.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── CARD DE OPÇÕES ──
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.surfaceBorder),
              ),
              child: Column(
                children: [
                  // Sair da Conta
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.logout_rounded, color: AppColors.error, size: 20),
                    ),
                    title: Text(
                      'Sair da conta',
                      style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600, color: AppColors.error),
                    ),
                    subtitle: Text(
                      'Desconectar desta conta da oficina',
                      style: AppTextStyles.bodySmall,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textHint),
                    onTap: () {
                      _showLogoutConfirmDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Sair da Conta'),
          content: const Text('Deseja realmente sair e desconectar desta conta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<AuthCubit>().signOut();
              },
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );
  }
}
