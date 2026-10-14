package lib.data.repositories;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:retail_app/core/constants/app_constants.dart';
import 'package:retail_app/domain/entities/cart_item.dart';
import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final SharedPreferences sharedPreferences;
  final List<CartItem> _cartItems = [];
  
  CartRepositoryImpl({required this.sharedPreferences}) {
    _loadCartFromStorage();
  }

  Future<void> _loadCartFromStorage() async {
    final cartJson = sharedPreferences.getString(PerformanceConstants.cartItemsKey);
    if (cartJson != null) {
      try {
        final List<dynamic> cartList = jsonDecode(cartJson);
        _cartItems.clear();
        _cartItems.addAll(cartList.map((item) => CartItem.fromJson(item)));
      } catch (e) {
        _cartItems.clear();
      }
    }
  }

  Future<void> _saveCartToStorage() async {
    final cartJson = jsonEncode(_cartItems.map((item) => item.toJson()).toList());
    await sharedPreferences.setString(PerformanceConstants.cartItemsKey, cartJson);
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    return List.unmodifiable(_cartItems);
  }

  @override
  Future<void> addToCart(Product product, {int quantity = 1}) async {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      final existingItem = _cartItems[existingIndex];
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      _cartItems[existingIndex] = updatedItem;
    } else {
      final newItem = CartItem(product: product, quantity: quantity);
      _cartItems.add(newItem);
    }
    
    await _saveCartToStorage();
  }

  @override
  Future<void> removeFromCart(String productId) async {
    _cartItems.removeWhere((item) => item.product.id == productId);
    await _saveCartToStorage();
  }

  @override
  Future<void> updateQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
      return;
    }
    
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      final updatedItem = _cartItems[index].copyWith(quantity: quantity);
      _cartItems[index] = updatedItem;
      await _saveCartToStorage();
    }
  }

  @override
  Future<void> clearCart() async {
    _cartItems.clear();
    await sharedPreferences.remove(PerformanceConstants.cartItemsKey);
  }

  @override
  Future<int> getCartItemCount() async {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Future<double> getCartTotal() async {
    return _cartItems.fold(0.0, (sum, item) {
      return sum + (item.product.price * item.quantity);
    });
  }

  @override
  Future<bool> isInCart(String productId) async {
    return _cartItems.any((item) => item.product.id == productId);
  }
}