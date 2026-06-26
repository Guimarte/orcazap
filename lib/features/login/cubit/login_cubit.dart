import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orcazap/data/repositories/shop_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SupabaseClient _client;
  final ShopRepository _shopRepository;

  LoginCubit(this._client, this._shopRepository) : super(LoginInitial());

  /// Após autenticar, verifica se o usuário já tem oficina.
  /// Emite [LoginSuccess] se tiver, [LoginSuccessNeedsShop] se não.
  /// Guarda contra emissão após o cubit ser fechado pelo GoRouter.
  Future<void> _checkShopAndEmit() async {
    if (isClosed) return;
    final hasShop = await _shopRepository.hasShop();
    if (isClosed) return;
    if (hasShop) {
      emit(LoginSuccess());
    } else {
      emit(LoginSuccessNeedsShop());
    }
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    try {
      const webClientId = String.fromEnvironment('GOOGLE_WEB_CLIENT_ID');
      final scopes = ['email', 'profile'];
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(serverClientId: webClientId);

      final googleUser =
          await googleSignIn.attemptLightweightAuthentication();
      if (isClosed) return;
      if (googleUser == null) {
        emit(LoginError('Falha ao iniciar sessão com Google.'));
        return;
      }

      final authorization =
          await googleUser.authorizationClient
              .authorizationForScopes(scopes) ??
          await googleUser.authorizationClient.authorizeScopes(scopes);

      final idToken = googleUser.authentication.idToken;
      if (isClosed) return;
      if (idToken == null) {
        emit(LoginError('Token de autenticação não encontrado.'));
        return;
      }

      await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );

      // Após o signIn, o GoRouter pode fechar este cubit antes de chegarmos aqui.
      await _checkShopAndEmit();
    } on AuthException catch (e) {
      if (isClosed) return;
      emit(LoginError(e.message));
    } catch (e) {
      if (isClosed) return;
      emit(LoginError('Erro inesperado: $e'));
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    emit(LoginLoading());
    try {
      await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      await _checkShopAndEmit();
    } on AuthException catch (e) {
      if (isClosed) return;
      emit(LoginError(e.message));
    } catch (e) {
      if (isClosed) return;
      emit(LoginError('Erro inesperado: $e'));
    }
  }
}
