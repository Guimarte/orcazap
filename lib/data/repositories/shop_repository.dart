import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:orcazap/data/models/shop_model.dart';

class ShopRepository {
  final SupabaseClient _client;

  ShopRepository(this._client);

  /// Retorna o ID do usuário logado ou `null`.
  String? get _userId => _client.auth.currentUser?.id;

  /// Busca a oficina do usuário logado.
  /// Retorna `null` se ainda não tiver oficina cadastrada.
  Future<ShopModel?> getMyShop() async {
    if (_userId == null) return null;

    final response = await _client
        .from('shops')
        .select()
        .eq('user_id', _userId!)
        .maybeSingle();

    return response != null ? ShopModel.fromMap(response) : null;
  }

  /// Verifica se o usuário logado já possui uma oficina.
  Future<bool> hasShop() async {
    final shop = await getMyShop();
    return shop != null;
  }

  /// Cria a oficina vinculada ao usuário logado.
  Future<void> createShop({
    required String shopName,
    required String ownerName,
    required String phone,
    required String city,
  }) async {
    if (_userId == null) {
      throw Exception('Usuário não autenticado.');
    }

    await _client.from('shops').insert({
      'user_id': _userId,
      'shop_name': shopName,
      'owner_name': ownerName,
      'phone': phone,
      'city': city,
    });
  }
}
