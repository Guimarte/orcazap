class ShopModel {
  final String id;
  final String userId;
  final String shopName;
  final String ownerName;
  final String phone;
  final String city;
  final DateTime createdAt;

  ShopModel({
    required this.id,
    required this.userId,
    required this.shopName,
    required this.ownerName,
    required this.phone,
    required this.city,
    required this.createdAt,
  });

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      shopName: map['shop_name'] as String? ?? '',
      ownerName: map['owner_name'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      city: map['city'] as String? ?? '',
      createdAt: map['created_at'] != null 
          ? DateTime.parse(map['created_at'].toString()) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'shop_name': shopName,
      'owner_name': ownerName,
      'phone': phone,
      'city': city,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
