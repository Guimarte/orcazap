import 'package:orcazap/data/models/budget_item_model.dart';

class BudgetModel {
  final String id;
  final String shopId;
  final String clientName;
  final String phone;
  final String cpfCnpj;
  final String brand;
  final String model;
  final String year;
  final String plate;
  final String km;
  final String vehicle;
  final double total;
  final double subtotal;
  final double discount;
  final String paymentMethod;
  final int validityDays;
  final String notes;
  final String status;
  final DateTime createdAt;
  final List<BudgetItemModel> items;

  BudgetModel({
    required this.id,
    required this.shopId,
    required this.clientName,
    required this.phone,
    required this.cpfCnpj,
    required this.brand,
    required this.model,
    required this.year,
    required this.plate,
    required this.km,
    required this.vehicle,
    required this.total,
    required this.subtotal,
    required this.discount,
    required this.paymentMethod,
    required this.validityDays,
    required this.notes,
    required this.status,
    required this.createdAt,
    this.items = const [],
  });

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    final itemsList = map['budget_items'] as List? ?? [];
    return BudgetModel(
      id: map['id'] as String,
      shopId: map['shop_id'] as String,
      clientName: map['client_name'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      cpfCnpj: map['cpf_cnpj'] as String? ?? '',
      brand: map['brand'] as String? ?? '',
      model: map['model'] as String? ?? '',
      year: map['year'] as String? ?? '',
      plate: map['plate'] as String? ?? '',
      km: map['km'] as String? ?? '',
      vehicle: map['vehicle'] as String? ?? '',
      total: (map['total'] as num?)?.toDouble() ?? 0.0,
      subtotal: (map['subtotal'] as num?)?.toDouble() ?? 0.0,
      discount: (map['discount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: map['payment_method'] as String? ?? '',
      validityDays: map['validity_days'] as int? ?? 7,
      notes: map['notes'] as String? ?? '',
      status: map['status'] as String? ?? 'pendente',
      createdAt: map['created_at'] != null 
          ? DateTime.parse(map['created_at'].toString()) 
          : DateTime.now(),
      items: itemsList
          .map((e) => BudgetItemModel.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
      'created_at': createdAt.toIso8601String(),
    };
  }
}
