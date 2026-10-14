package retail_app.domain.usecases;

import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/domain/entities/cart_item.dart';
import 'package:retail_app/domain/repositories/cart_repository.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';
import 'package:retail_app/core/constants/app_constants.dart';

class AddToCartUseCase {
  final CartRepository _cartRepository;
  final PerformanceMonitor _performanceMonitor;
  
  AddToCartUseCase({
    required CartRepository cartRepository,
    required PerformanceMonitor performanceMonitor,
  })  : _cartRepository = cartRepository,
        _performanceMonitor = performanceMonitor;

  Future<CartItem> execute({
    required Product product,
    int quantity = 1,
  }) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      if (quantity <= 0) {
        throw ArgumentError('La cantidad debe ser mayor que cero');
      }
      
      if (!product.isInStock) {
        throw StateError('El producto ${product.name} no está disponible en stock');
      }
      
      if (quantity > product.stock) {
        throw StateError('Stock insuficiente. Disponible: ${product.stock}');
      }
      
      final existingItems = await _cartRepository.getCartItems();
      final existingIndex = existingItems.indexWhere(
        (item) => item.productId == product.id,
      );
      
      CartItem cartItem;
      
      if (existingIndex >= 0) {
        final existingItem = existingItems[existingIndex];
        final newQuantity = existingItem.quantity + quantity;
        
        if (newQuantity > product.stock) {
          throw StateError(
            'No se puede agregar más. Stock máximo: ${product.stock}',
          );
        }
        
        cartItem = await _cartRepository.updateCartItem(
          cartItemId: existingItem.id,
          quantity: newQuantity,
        );
      } else {
        cartItem = await _cartRepository.addCartItem(
          productId: product.id,
          quantity: quantity,
          price: product.price,
        );
      }
      
      stopwatch.stop();
      _recordCartOperationMetrics(stopwatch.elapsed, product.id);
      
      return cartItem;
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  void _recordCartOperationMetrics(Duration operationTime, String productId) {
    if (operationTime > PerformanceConstants.maxNetworkLatency) {
      _performanceMonitor._checkPerformanceAlerts(
        PerformanceSample(
          timestamp: DateTime.now(),
          cpuUsage: _performanceMonitor._getCpuUsage(),
          memoryUsageMB: _performanceMonitor._getMemoryUsage(),
          frameBuildTime: _performanceMonitor._getFrameBuildTime(),
        ),
      );
    }
  }

  Future<List<CartItem>> getCartItems() async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final items = await _cartRepository.getCartItems();
      
      stopwatch.stop();
      return items;
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  Future<void> removeFromCart(String cartItemId) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      await _cartRepository.removeCartItem(cartItemId);
      
      stopwatch.stop();
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  Future<CartItem> updateQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      if (quantity <= 0) {
        await _cartRepository.removeCartItem(cartItemId);
        stopwatch.stop();
        throw StateError('Artículo eliminado del carrito');
      }
      
      final updatedItem = await _cartRepository.updateCartItem(
        cartItemId: cartItemId,
        quantity: quantity,
      );
      
      stopwatch.stop();
      return updatedItem;
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  Future<double> calculateCartTotal() async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final items = await _cartRepository.getCartItems();
      
      double total = 0.0;
      for (final item in items) {
        total += item.price * item.quantity;
      }
      
      stopwatch.stop();
      return total;
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  Future<int> getCartItemCount() async {
    final items = await _cartRepository.getCartItems();
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  Future<void> clearCart() async {
    final stopwatch = Stopwatch()..start();
    
    try {
      await _cartRepository.clearCart();
      
      stopwatch.stop();
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }
}