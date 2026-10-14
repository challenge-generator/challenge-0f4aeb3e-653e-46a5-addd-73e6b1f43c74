package lib.domain.entities;

import 'package:retail_app/domain/entities/product.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;
  final double unitPrice;
  final double? discountPercentage;
  final DateTime addedAt;
  final String? promotionCode;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    this.discountPercentage,
    required this.addedAt,
    this.promotionCode,
  });

  double get discountAmount {
    if (discountPercentage == null || discountPercentage == 0) {
      return 0.0;
    }
    return (unitPrice * quantity) * (discountPercentage! / 100);
  }

  double get subtotal => (unitPrice * quantity) - discountAmount;

  double get totalWeight => product.metadata?['weight'] != null 
      ? (product.metadata!['weight'] as num).toDouble() * quantity 
      : 0.0;

  bool get isEligibleForFreeShipping => subtotal >= 50.0;

  bool get hasPromotion => promotionCode != null && promotionCode!.isNotEmpty;

  bool get canIncreaseQuantity => quantity < product.stock;

  bool get canDecreaseQuantity => quantity > 1;

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    double? unitPrice,
    double? discountPercentage,
    DateTime? addedAt,
    String? promotionCode,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      addedAt: addedAt ?? this.addedAt,
      promotionCode: promotionCode ?? this.promotionCode,
    );
  }

  CartItem incrementQuantity([int amount = 1]) {
    final newQuantity = quantity + amount;
    if (newQuantity > product.stock) {
      throw CartItemException(
        'Cannot exceed available stock. Available: ${product.stock}, requested: $newQuantity',
      );
    }
    return copyWith(quantity: newQuantity);
  }

  CartItem decrementQuantity([int amount = 1]) {
    final newQuantity = quantity - amount;
    if (newQuantity < 1) {
      throw CartItemException('Quantity cannot be less than 1');
    }
    return copyWith(quantity: newQuantity);
  }

  CartItem applyPromotion(String code, double discountPercent) {
    return copyWith(
      promotionCode: code,
      discountPercentage: discountPercent,
    );
  }

  CartItem removePromotion() {
    return CartItem(
      id: id,
      product: product,
      quantity: quantity,
      unitPrice: unitPrice,
      discountPercentage: null,
      addedAt: addedAt,
      promotionCode: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'unitPrice': unitPrice,
      'discountPercentage': discountPercentage,
      'addedAt': addedAt.toIso8601String(),
      'promotionCode': promotionCode,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      discountPercentage: json['discountPercentage'] != null
          ? (json['discountPercentage'] as num).toDouble()
          : null,
      addedAt: DateTime.parse(json['addedAt'] as String),
      promotionCode: json['promotionCode'] as String?,
    );
  }

  @override
  String toString() {
    return 'CartItem(id: $id, product: ${product.name}, quantity: $quantity, unitPrice: $unitPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class CartItemException implements Exception {
  final String message;
  const CartItemException(this.message);

  @override
  String toString() => 'CartItemException: $message';
}

class CartItemValidator {
  static ValidationResult validate(CartItem item) {
    final errors = <String>[];

    if (item.id.isEmpty) {
      errors.add('Cart item ID cannot be empty');
    }

    if (item.quantity < 1) {
      errors.add('Quantity must be at least 1');
    }

    if (item.quantity > item.product.stock) {
      errors.add('Quantity exceeds available stock: ${item.product.stock}');
    }

    if (item.unitPrice < 0) {
      errors.add('Unit price cannot be negative');
    }

    if (item.discountPercentage != null) {
      if (item.discountPercentage! < 0 || item.discountPercentage! > 100) {
        errors.add('Discount percentage must be between 0 and 100');
      }
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  static bool canAddToCart(Product product, int currentQuantity, int amountToAdd) {
    return (currentQuantity + amountToAdd) <= product.stock;
  }
}

class ValidationResult {
  final bool isValid;
  final List<String> errors;

  const ValidationResult({
    required this.isValid,
    required this.errors,
  });

  String get errorMessage => errors.join('; ');
}