import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────
// 🎨 PALETA DE CORES — OrcaZap
// ─────────────────────────────────────────────

class AppColors {
  AppColors._();

  // ── Superfícies ──
  static const Color background = Color(0xFF0D0D0D);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color surfaceLight = Color(0xFF242424);
  static const Color surfaceBorder = Color(0xFF2E2E2E);

  // ── Texto ──
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color textHint = Color(0xFF737373);

  // ── Destaque principal (Amarelo Automotivo) ──
  static const Color primary = Color(0xFFFFB300);
  static const Color primaryLight = Color(0xFFFFCA28);
  static const Color primaryDark = Color(0xFFFF8F00);
  static const Color onPrimary = Color(0xFF1A1A1A);

  // ── Status ──
  static const Color success = Color(0xFF4CAF50);
  static const Color successBg = Color(0x1A4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color warningBg = Color(0x1AFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color errorBg = Color(0x1AF44336);

  // ── Extras ──
  static const Color divider = Color(0xFF2A2A2A);
  static const Color shimmer = Color(0xFF333333);
  static const Color overlay = Color(0x80000000);
}

// ─────────────────────────────────────────────
// 📐 ESPAÇAMENTOS E RAIOS
// ─────────────────────────────────────────────

class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class AppRadius {
  AppRadius._();

  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double full = 999.0;

  static BorderRadius get smallBorder => BorderRadius.circular(sm);
  static BorderRadius get mediumBorder => BorderRadius.circular(md);
  static BorderRadius get largeBorder => BorderRadius.circular(lg);
  static BorderRadius get xlBorder => BorderRadius.circular(xl);
}

// ─────────────────────────────────────────────
// 🔤 ESTILOS DE TEXTO
// ─────────────────────────────────────────────

class AppTextStyles {
  AppTextStyles._();

  // ── Cabeçalhos ──
  static const TextStyle h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.3,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // ── Corpo ──
  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodySecondary = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // ── Botões e Labels ──
  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    height: 1.0,
  );

  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
    height: 1.0,
  );

  // ── Valores monetários ──
  static const TextStyle currency = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    letterSpacing: -0.3,
  );

  static const TextStyle currencySmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
}

// ─────────────────────────────────────────────
// 🏗️ TEMA MATERIAL COMPLETO
// ─────────────────────────────────────────────

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // ── Cores base ──
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.primaryLight,
        onSecondary: AppColors.onPrimary,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.error,
        onError: AppColors.textPrimary,
      ),

      scaffoldBackgroundColor: AppColors.background,

      // ── AppBar ──
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary, size: 22),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.background,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),

      // ── Cards ──
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mediumBorder,
          side: const BorderSide(color: AppColors.surfaceBorder, width: 1),
        ),
      ),

      // ── Botões Elevados (Primário) ──
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumBorder),
          textStyle: AppTextStyles.button,
          minimumSize: const Size(double.infinity, 52),
        ),
      ),

      // ── Botões Outlined (Secundário) ──
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumBorder),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          textStyle: AppTextStyles.button,
          minimumSize: const Size(double.infinity, 52),
        ),
      ),

      // ── Botões de Texto ──
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.button,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
      ),

      // ── Inputs ──
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        hintStyle: AppTextStyles.bodySecondary.copyWith(
          color: AppColors.textHint,
        ),
        labelStyle: AppTextStyles.bodySecondary,
        floatingLabelStyle: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.mediumBorder,
          borderSide: const BorderSide(color: AppColors.surfaceBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mediumBorder,
          borderSide: const BorderSide(color: AppColors.surfaceBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mediumBorder,
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mediumBorder,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mediumBorder,
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),

      // ── FloatingActionButton ──
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.largeBorder),
      ),

      // ── Chips ──
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedColor: AppColors.primary.withValues(alpha: 0.2),
        labelStyle: AppTextStyles.bodySmall,
        side: const BorderSide(color: AppColors.surfaceBorder),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.smallBorder),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),

      // ── BottomNavigationBar ──
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textHint,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ── Divider ──
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 0,
      ),

      // ── Dialogs ──
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.largeBorder),
        titleTextStyle: AppTextStyles.h3,
        contentTextStyle: AppTextStyles.body,
      ),

      // ── SnackBar ──
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        contentTextStyle: AppTextStyles.body,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.smallBorder),
      ),

      // ── ListTile ──
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        iconColor: AppColors.textSecondary,
        textColor: AppColors.textPrimary,
      ),

      // ── ProgressIndicator ──
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.surfaceLight,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 🏷️ HELPERS DE STATUS (para orçamentos)
// ─────────────────────────────────────────────

class StatusHelper {
  StatusHelper._();

  static Color color(String status) {
    return switch (status) {
      'aprovado' => AppColors.success,
      'recusado' => AppColors.error,
      _ => AppColors.warning, // pendente
    };
  }

  static Color backgroundColor(String status) {
    return switch (status) {
      'aprovado' => AppColors.successBg,
      'recusado' => AppColors.errorBg,
      _ => AppColors.warningBg,
    };
  }

  static IconData icon(String status) {
    return switch (status) {
      'aprovado' => Icons.check_circle_rounded,
      'recusado' => Icons.cancel_rounded,
      _ => Icons.schedule_rounded,
    };
  }

  static String label(String status) {
    return switch (status) {
      'aprovado' => 'Aprovado',
      'recusado' => 'Recusado',
      _ => 'Pendente',
    };
  }
}
