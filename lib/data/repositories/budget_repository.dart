import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:orcazap/data/models/budget_model.dart';
import 'package:orcazap/data/models/budget_item_model.dart';

class BudgetRepository {
  final SupabaseClient _client;

  BudgetRepository(this._client);

  /// Busca os orçamentos recentes de uma oficina,
  /// incluindo a lista de itens de cada orçamento.
  Future<List<BudgetModel>> getRecentBudgets(
    String shopId, {
    int limit = 10,
  }) async {
    final response = await _client
        .from('budgets')
        .select('*, budget_items(*)')
        .eq('shop_id', shopId)
        .order('created_at', ascending: false)
        .limit(limit);

    return (response as List).map((e) => BudgetModel.fromMap(e)).toList();
  }

  /// Retorna as estatísticas do dashboard:
  /// - `todayCount`: orçamentos criados hoje
  /// - `approvedCount`: orçamentos aprovados (geral)
  /// - `pendingCount`: orçamentos pendentes (geral)
  /// - `weekRevenue`: soma dos orçamentos aprovados na semana
  /// - `weekOrdersCount`: total de orçamentos na semana
  Future<Map<String, dynamic>> getBudgetStats(String shopId) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day).toIso8601String();
    final weekStart =
        DateTime(now.year, now.month, now.day - now.weekday + 1)
            .toIso8601String();

    // ── Orçamentos de hoje ──
    final todayResponse = await _client
        .from('budgets')
        .select('id')
        .eq('shop_id', shopId)
        .gte('created_at', todayStart);

    // ── Aprovados (geral) ──
    final approvedResponse = await _client
        .from('budgets')
        .select('id')
        .eq('shop_id', shopId)
        .eq('status', 'aprovado');

    // ── Pendentes (geral) ──
    final pendingResponse = await _client
        .from('budgets')
        .select('id')
        .eq('shop_id', shopId)
        .eq('status', 'pendente');

    // ── Faturamento da semana (aprovados) ──
    final weekRevenueResponse = await _client
        .from('budgets')
        .select('total')
        .eq('shop_id', shopId)
        .eq('status', 'aprovado')
        .gte('created_at', weekStart);

    double weekRevenue = 0;
    for (final row in weekRevenueResponse) {
      weekRevenue += (row['total'] as num).toDouble();
    }

    // ── Total de ordens na semana ──
    final weekOrdersResponse = await _client
        .from('budgets')
        .select('id')
        .eq('shop_id', shopId)
        .gte('created_at', weekStart);

    return {
      'todayCount': (todayResponse as List).length,
      'approvedCount': (approvedResponse as List).length,
      'pendingCount': (pendingResponse as List).length,
      'weekRevenue': weekRevenue,
      'weekOrdersCount': (weekOrdersResponse as List).length,
    };
  }

  Future<BudgetModel> createBudget({
    required String shopId,
    required String clientName,
    required String phone,
    required String cpfCnpj,
    required String brand,
    required String model,
    required String year,
    required String plate,
    required String km,
    required String vehicle,
    required double total,
    required double subtotal,
    required double discount,
    required String paymentMethod,
    required int validityDays,
    required String notes,
    required List<BudgetItemModel> items,
    String status = 'pendente',
  }) async {
    final response = await _client.from('budgets').insert({
      'shop_id': shopId,
      'client_name': clientName,
      'phone': phone,
      'cpf_cnpj': cpfCnpj,
      'brand': brand,
      'model': model,
      'year': year,
      'plate': plate,
      'km': km,
      'vehicle': vehicle,
      'total': total,
      'subtotal': subtotal,
      'discount': discount,
      'payment_method': paymentMethod,
      'validity_days': validityDays,
      'notes': notes,
      'status': status,
    }).select('id').single();

    final budgetId = response['id'] as String;

    if (items.isNotEmpty) {
      final itemsToInsert = items.map((item) => {
        'budget_id': budgetId,
        'description': item.description,
        'quantity': item.quantity,
        'unit_price': item.unitPrice,
        'type': item.type,
      }).toList();

      await _client.from('budget_items').insert(itemsToInsert);
    }

    return getBudgetById(budgetId);
  }

  /// Busca um orçamento específico pelo seu ID, incluindo seus itens.
  Future<BudgetModel> getBudgetById(String budgetId) async {
    final response = await _client
        .from('budgets')
        .select('*, budget_items(*)')
        .eq('id', budgetId)
        .single();
    return BudgetModel.fromMap(response);
  }

  /// Atualiza um orçamento existente e reconstrói seus itens.
  Future<BudgetModel> updateBudget({
    required String budgetId,
    required String clientName,
    required String phone,
    required String cpfCnpj,
    required String brand,
    required String model,
    required String year,
    required String plate,
    required String km,
    required String vehicle,
    required double total,
    required double subtotal,
    required double discount,
    required String paymentMethod,
    required int validityDays,
    required String notes,
    required List<BudgetItemModel> items,
    String? status,
  }) async {
    // 1. Atualiza dados principais
    final updateData = {
      'client_name': clientName,
      'phone': phone,
      'cpf_cnpj': cpfCnpj,
      'brand': brand,
      'model': model,
      'year': year,
      'plate': plate,
      'km': km,
      'vehicle': vehicle,
      'total': total,
      'subtotal': subtotal,
      'discount': discount,
      'payment_method': paymentMethod,
      'validity_days': validityDays,
      'notes': notes,
    };
    if (status != null) {
      updateData['status'] = status;
    }

    await _client.from('budgets').update(updateData).eq('id', budgetId);

    // 2. Remove itens antigos
    await _client.from('budget_items').delete().eq('budget_id', budgetId);

    // 3. Insere itens novos/atualizados
    if (items.isNotEmpty) {
      final itemsToInsert = items.map((item) => {
        'budget_id': budgetId,
        'description': item.description,
        'quantity': item.quantity,
        'unit_price': item.unitPrice,
        'type': item.type,
      }).toList();

      await _client.from('budget_items').insert(itemsToInsert);
    }

    return getBudgetById(budgetId);
  }

  /// Busca todos os orçamentos de uma oficina, incluindo seus itens.
  Future<List<BudgetModel>> getAllBudgets(String shopId) async {
    final response = await _client
        .from('budgets')
        .select('*, budget_items(*)')
        .eq('shop_id', shopId)
        .order('created_at', ascending: false);

    return (response as List).map((e) => BudgetModel.fromMap(e)).toList();
  }
}

