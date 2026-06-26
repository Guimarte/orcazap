import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcazap/data/repositories/shop_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final SupabaseClient _client;
  final ShopRepository _shopRepository;

  RegisterCubit(this._client, this._shopRepository)
      : super(RegisterInitial());

  /// Cadastro manual (e-mail + senha) — cria conta no Auth e depois
  /// insere o perfil da oficina via repository.
  Future<void> register({
    required String shopName,
    required String ownerName,
    required String phone,
    required String city,
    String? email,
    String? password,
    required bool isGoogleSignUp,
  }) async {
    emit(RegisterLoading());
    try {
      if (!isGoogleSignUp) {
        // ── Cadastro com e-mail + senha ──
        await _client.auth.signUp(
          email: email!,
          password: password!,
        );
        if (isClosed) return;
      }

      // ── Salvar perfil da oficina via repository ──
      await _shopRepository.createShop(
        shopName: shopName,
        ownerName: ownerName,
        phone: phone,
        city: city,
      );

      if (isClosed) return;
      emit(RegisterSuccess());
    } on AuthException catch (e) {
      if (isClosed) return;
      emit(RegisterError(e.message));
    } catch (e) {
      if (isClosed) return;
      emit(RegisterError('Erro inesperado: $e'));
    }
  }
}
