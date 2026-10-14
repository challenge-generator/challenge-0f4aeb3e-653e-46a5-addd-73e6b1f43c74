package lib.domain.repositories;

import 'package:retail_app/domain/entities/cart_item.dart';
import 'package:retail_app/domain/entities/product.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCartItems();

  Future<CartItem?> getCartItemById(String id);

  Future<CartItem?> getCartItemByProductId(String productId);

  Future<CartItem> addToCart(Product product, {int quantity = 1, String? promotionCode});

  Future<CartItem> updateCartItemQuantity(String itemId, int quantity);

  Future<CartItem> incrementCartItemQuantity(String itemId, {int amount = 1});

  Future<CartItem> decrementCartItemQuantity(String itemId, {int amount = 1});

  Future<void> removeFromCart(String itemId);

  Future<void> clearCart();

  Future<void> applyPromotionToItem(String itemId, String promotionCode, double discountPercent);

  Future<void> removePromotionFromItem(String itemId);

  Future<CartSummary> getCartSummary();

  Future<int> getCartItemCount();

  Future<bool> isProductInCart(String productId);

  Stream<List<CartItem>> watchCartItems();

  Future<void> syncCartWithServer();

  Future<void> restoreCartFromLocal();

  Future<void> saveCartLocally();
}

class CartSummary {
  final int totalItems;
  final double subtotal;
  final double discount;
  final double shipping;
  final double tax;
  final double total;
  final List<CartItem> items;
  final String? appliedCoupon;
  final bool qualifiesForFreeShipping;
  final double amountUntilFreeShipping;

  const CartSummary({
    required this.totalItems,
    required this.subtotal,
    required this.discount,
    required this.shipping,
    required this.tax,
    required this.total,
    required this.items,
    this.appliedCoupon,
    required this.qualifiesForFreeShipping,
    required this.amountUntilFreeShipping,
  });

  factory CartSummary.empty() {
    return const CartSummary(
      totalItems: 0,
      subtotal: 0.0,
      discount: 0.0,
      shipping: 0.0,
      tax: 0.0,
      total: 0.0,
      items: [],
      qualifiesForFreeShipping: false,
      amountUntilFreeShipping: 50.0,
    );
  }

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  double get totalWeight => items.fold(0.0, (sum, item) => sum + item.totalWeight);

  String get shippingStatus {
    if (qualifiesForFreeShipping) {
      return 'Envío gratis';
    }
    return 'Añade \$${amountUntilFreeShipping.toStringAsFixed(2)} más para envío gratis';
  }

  Map<String, dynamic> toJson() {
    return {
      'totalItems': totalItems,
      'subtotal': subtotal,
      'discount': discount,
      'shipping': shipping,
      'tax': tax,
      'total': total,
      'items': items.map((e) => e.toJson()).toList(),
      'appliedCoupon': appliedCoupon,
      'qualifiesForFreeShipping': qualifiesForFreeShipping,
      'amountUntilFreeShipping': amountUntilFreeShipping,
    };
  }
}

class CartRepositoryException implements Exception {
  final String message;
  final CartRepositoryErrorType type;
  final dynamic originalError;

  const CartRepositoryException({
    required this.message,
    required this.type,
    this.originalError,
  });

  @override
  String toString() => 'CartRepositoryException: $message (type: $type)';

  bool get isNetworkError => type == CartRepositoryErrorType.networkError;
  bool get isStorageError => type == CartRepositoryErrorType.storageError;
  bool get isValidationError => type == CartRepositoryErrorType.validationError;
  bool get isNotFound => type == CartRepositoryErrorType.notFound;
}

enum CartRepositoryErrorType {
  networkError,
  storageError,
  validationError,
  notFound,
  productOutOfStock,
  unknown,
}

class CartOperationResult {
  final bool success;
  final CartItem? item;
  final CartSummary? summary;
  final String? errorMessage;
  final CartRepositoryErrorType? errorType;

  const CartOperationResult({
    required this.success,
    this.item,
    this.summary,
    this.errorMessage,
    this.errorType,
  });

  factory CartOperationResult.success({
    CartItem? item,
    CartSummary? summary,
  }) {
    return CartOperationResult(
      success: true,
      item: item,
      summary: summary,
    );
  }

  factory CartOperationResult.failure({
    required String message,
    required CartRepositoryErrorType type,
    CartItem? item,
    CartSummary? summary,
  }) {
    return CartOperationResult(
      success: false,
      item: item,
      summary: summary,
      errorMessage: message,
      errorType: type,
    );
  }
}

class CartPromotions {
  static const double freeShippingThreshold = 50.0;
  static const double defaultShippingCost = 5.99;
  static const double taxRate = 0.08;

  static double calculateShipping(double subtotal) {
    if (subtotal >= freeShippingThreshold) {
      return 0.0;
    }
    return defaultShippingCost;
  }

  static double calculateTax(double subtotal) {
    return subtotal * taxRate;
  }

  static double calculateAmountUntilFreeShipping(double subtotal) {
    final remaining = freeShippingThreshold - subtotal;
    return remaining > 0 ? remaining : 0.0;
  }

  static bool qualifiesForFreeShipping(double subtotal) {
    return subtotal >= freeShippingThreshold;
  }
}

class CartValidator {
  static CartOperationResult validateAddToCart(Product product, int quantity) {
    if (quantity < 1) {
      return CartOperationResult.failure(
        message: 'La cantidad debe ser al menos 1',
        type: CartRepositoryErrorType.validationError,
      );
    }

    if (quantity > product.stock) {
      return CartOperationResult.failure(
        message: 'Stock insuficiente. Disponible: ${product.stock}',
        type: CartRepositoryErrorType.productOutOfStock,
      );
    }

    if (!product.isInStock) {
      return CartOperationResult.failure(
        message: 'El producto no está disponible',
        type: CartRepositoryErrorType.productOutOfStock,
      );
    }

    return CartOperationResult.success();
  }

  static CartOperationResult validateQuantity(int currentQuantity, int newQuantity, int maxStock) {
    if (newQuantity < 1) {
      return CartOperationResult.failure(
        message: 'La cantidad no puede ser menor a 1',
        type: CartRepositoryErrorType.validationError,
      );
    }

    if (newQuantity > maxStock) {
      return CartOperationResult.failure(
        message: 'Stock insuficiente para esta cantidad',
        type: CartRepositoryErrorType.productOutOfStock,
      );
    }

    return CartOperationResult.success();
  }
}