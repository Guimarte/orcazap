import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthSessionState> {
  final SupabaseClient _client;

  AuthCubit(this._client) : super(AuthSessionInitial(_client.auth.currentUser));

  Future<void> signOut() async {
    emit(AuthSessionLoading());
    await _client.auth.signOut();
    if (isClosed) return;
    emit(AuthSessionInitial(null));
  }
}
