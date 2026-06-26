import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcazap/data/repositories/budget_repository.dart';
import 'package:orcazap/data/repositories/shop_repository.dart';
import 'package:orcazap/data/models/shop_model.dart';
import 'package:orcazap/data/models/budget_model.dart';
import 'package:orcazap/data/models/budget_item_model.dart';

part 'create_budget_state.dart';

class CreateBudgetCubit extends Cubit<CreateBudgetState> {
  final BudgetRepository _budgetRepository;
  final ShopRepository _shopRepository;
  final String _shopId;
  final String? _budgetId;

  ShopModel? shopDetails;
  BudgetModel? initialBudgetData;

  bool get isEditMode => _budgetId != null;

  CreateBudgetCubit(
    this._budgetRepository,
    this._shopRepository,
    this._shopId, {
    String? budgetId,
  })  : _budgetId = budgetId,
        super(budgetId != null ? const CreateBudgetLoading() : const CreateBudgetEditing([])) {
    _init();
  }

  Future<void> _init() async {
    await _loadShopDetails();
    if (_budgetId != null) {
      await _loadBudgetData();
    }
  }

  Future<void> _loadShopDetails() async {
    try {
      shopDetails = await _shopRepository.getMyShop();
    } catch (_) {}
  }

  Future<void> _loadBudgetData() async {
    try {
      final budget = await _budgetRepository.getBudgetById(_budgetId!);
      initialBudgetData = budget;
      
      final loadedItems = budget.items.map((e) => BudgetItemModel(
        id: e.id,
        budgetId: e.budgetId,
        type: e.type,
        description: e.description,
        quantity: e.quantity,
        unitPrice: e.unitPrice,
      )).toList();

      emit(CreateBudgetEditing(loadedItems));
    } catch (e) {
      emit(CreateBudgetError(const [], 'Erro ao carregar dados do orçamento: $e'));
    }
  }

  List<BudgetItemModel> get _items => List.of(state.items);

  /// Adiciona um item (serviço ou peça) à lista.
  void addItem(String type) {
    final items = _items..add(BudgetItemModel(type: type));
    emit(CreateBudgetEditing(items));
  }

  /// Remove um item pelo índice.
  void removeItem(int index) {
    final items = _items..removeAt(index);
    emit(CreateBudgetEditing(items));
  }

  /// Atualiza a descrição de um item.
  void updateDescription(int index, String description) {
    final items = _items;
    items[index].description = description;
    emit(CreateBudgetEditing(items));
  }

  /// Atualiza a quantidade de um item.
  void updateQuantity(int index, int quantity) {
    final items = _items;
    items[index].quantity = quantity;
    emit(CreateBudgetEditing(items));
  }

  /// Atualiza o preço unitário de um item.
  void updateUnitPrice(int index, double unitPrice) {
    final items = _items;
    items[index].unitPrice = unitPrice;
    emit(CreateBudgetEditing(items));
  }

  Future<void> saveBudget({
    required String clientName,
    required String phone,
    required String cpfCnpj,
    required String brand,
    required String model,
    required String year,
    required String plate,
    required String km,
    required String paymentMethod,
    required int validityDays,
    required String notes,
    required double discount,
    String? status,
  }) async {
    final items = _items;
    emit(CreateBudgetSaving(items));
    try {
      final subtotal = state.subtotal;
      final total = subtotal - discount;

      final BudgetModel savedBudget;
      if (_budgetId != null) {
        savedBudget = await _budgetRepository.updateBudget(
          budgetId: _budgetId,
          clientName: clientName,
          phone: phone,
          cpfCnpj: cpfCnpj,
          brand: brand,
          model: model,
          year: year,
          plate: plate,
          km: km,
          vehicle: '$brand $model'.trim(),
          total: total > 0 ? total : 0,
          subtotal: subtotal,
          discount: discount,
          paymentMethod: paymentMethod,
          validityDays: validityDays,
          notes: notes,
          items: items,
          status: status,
        );
      } else {
        savedBudget = await _budgetRepository.createBudget(
          shopId: _shopId,
          clientName: clientName,
          phone: phone,
          cpfCnpj: cpfCnpj,
          brand: brand,
          model: model,
          year: year,
          plate: plate,
          km: km,
          vehicle: '$brand $model'.trim(),
          total: total > 0 ? total : 0,
          subtotal: subtotal,
          discount: discount,
          paymentMethod: paymentMethod,
          validityDays: validityDays,
          notes: notes,
          items: items,
          status: status ?? 'pendente',
        );
      }

      emit(CreateBudgetSuccess(savedBudget));
    } catch (e) {
      emit(CreateBudgetError(items, 'Erro ao salvar orçamento: $e'));
    }
  }
}
