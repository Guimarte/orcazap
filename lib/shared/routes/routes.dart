import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orcazap/data/repositories/budget_repository.dart';
import 'package:orcazap/data/repositories/shop_repository.dart';
import 'package:orcazap/features/home/cubit/auth_cubit.dart';
import 'package:orcazap/features/home/cubit/home_cubit.dart';
import 'package:orcazap/features/home/home_view.dart';
import 'package:orcazap/features/login/cubit/login_cubit.dart';
import 'package:orcazap/features/login/login_view.dart';
import 'package:orcazap/features/register/cubit/register_cubit.dart';
import 'package:orcazap/features/register/register_view.dart';
import 'package:orcazap/shared/widgets/app_shell.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:orcazap/features/create_budget/cubit/create_budget_cubit.dart';
import 'package:orcazap/features/create_budget/create_budget_page.dart';

class Routes {
  Routes._();

  static late final GoRouter router;

  static void init(SupabaseClient client) {
    final shopRepository = ShopRepository(client);
    final budgetRepository = BudgetRepository(client);

    router = GoRouter(
      initialLocation: '/',
      refreshListenable: _SupabaseAuthNotifier(client),
      redirect: (context, state) {
        final isLoggedIn = client.auth.currentSession != null;
        final isOnLogin = state.matchedLocation == '/';
        final isOnRegister = state.matchedLocation == '/register';

        if (!isLoggedIn && !isOnLogin && !isOnRegister) return '/';
        if (isLoggedIn && isOnLogin) return '/home';
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider(
            create: (_) => LoginCubit(client, shopRepository),
            child: const LoginView(),
          ),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    HomeCubit(shopRepository, budgetRepository)
                      ..loadDashboard(),
              ),
              BlocProvider(create: (_) => AuthCubit(client)),
            ],
            child: AppShell(
              dashboard: const HomeView(),
              budgetRepository: budgetRepository,
            ),
          ),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) {
            final isGoogle = state.uri.queryParameters['isGoogle'] == 'true';
            return BlocProvider(
              create: (_) => RegisterCubit(client, shopRepository),
              child: RegisterView(isGoogleSignUp: isGoogle),
            );
          },
        ),
        GoRoute(
          path: '/new_budget',
          builder: (context, state) {
            final shopId = state.uri.queryParameters['shopId'] ?? '';
            final budgetId = state.uri.queryParameters['budgetId'];
            return BlocProvider(
              create: (_) => CreateBudgetCubit(
                budgetRepository,
                shopRepository,
                shopId,
                budgetId: budgetId,
              ),
              child: const CreateBudgetPage(),
            );
          },
        ),
      ],
    );
  }
}

/// Notifica o GoRouter sempre que o estado de autenticação do Supabase mudar.
class _SupabaseAuthNotifier extends ChangeNotifier {
  _SupabaseAuthNotifier(SupabaseClient client) {
    client.auth.onAuthStateChange.listen((_) {
      notifyListeners();
    });
  }
}
