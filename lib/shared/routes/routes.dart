import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orcazap/features/home/home_page.dart';
import 'package:orcazap/features/login/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Routes {
  Routes._();

  static final _authNotifier = _SupabaseAuthNotifier();

  static final router = GoRouter(
    initialLocation: '/',
    refreshListenable: _authNotifier,
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggedIn = session != null;
      final isOnLogin = state.matchedLocation == '/';

      if (!isLoggedIn && !isOnLogin) return '/';
      if (isLoggedIn && isOnLogin) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ],
  );
}

/// Notifica o GoRouter sempre que o estado de autenticação do Supabase mudar.
class _SupabaseAuthNotifier extends ChangeNotifier {
  _SupabaseAuthNotifier() {
    Supabase.instance.client.auth.onAuthStateChange.listen((_) {
      notifyListeners();
    });
  }
}
