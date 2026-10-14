package retail_app.presentation.viewmodels;

import 'package:flutter/foundation.dart';
import 'package:retail_app/domain/entities/cart_item.dart';
import 'package:retail_app/domain/repositories/cart_repository.dart';
import 'package:retail_app/domain/usecases/add_to_cart_usecase.dart';
import 'package:retail_app/core/constants/app_constants.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';

enum CartLoadingState { initial, loading, loaded, error }

class CartViewModel extends ChangeNotifier {
  final AddToCartUseCase _addToCartUseCase;
  final CartRepository _cartRepository;
  final PerformanceMonitor _performanceMonitor;

  CartViewModel({
    required AddToCartUseCase addToCartUseCase,
    required CartRepository cartRepository,
    PerformanceMonitor? performanceMonitor,
  })  : _addToCartUseCase = addToCartUseCase,
        _cartRepository = cartRepository,
        _performanceMonitor = performanceMonitor ?? PerformanceMonitor();

  CartLoadingState _loadingState = CartLoadingState.initial;
  List<CartItem> _items = [];
  String? _errorMessage;

  CartLoadingState get loadingState => _loadingState;
  
  List<CartItem> get items => _items;
  
  String? get errorMessage => _errorMessage;
  
  bool get isLoading => _loadingState == CartLoadingState.loading;
  
  bool get isEmpty => _items.isEmpty;

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice {
    final stopwatch = Stopwatch()..start();
    final total = _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    stopwatch.stop();
    
    if (stopwatch.elapsed > PerformanceConstants.maxFrameBuildTime) {
      _performanceMonitor.recordWidgetBuildTime('CartViewModel_totalPrice', stopwatch.elapsed);
    }
    
    return total;
  }

  int get uniqueProductCount => _items.length;

  Future<void> loadCart() async {
    if (_loadingState == CartLoadingState.loading) return;
    
    _loadingState = CartLoadingState.loading;
    _errorMessage = null;
    notifyListeners();

    final stopwatch = Stopwatch()..start();
    
    try {
      _items = await _cartRepository.getCartItems();
      stopwatch.stop();
      
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      _loadingState = CartLoadingState.loaded;
    } catch (e) {
      stopwatch.stop();
      _errorMessage = 'Error al cargar el carrito: ${e.toString()}';
      _loadingState = CartLoadingState.error;
    }
    
    notifyListeners();
  }

  Future<bool> addToCart(String productId, String productName, double price, {int quantity = 1}) async {
    _loadingState = CartLoadingState.loading;
    _errorMessage = null;
    notifyListeners();

    final stopwatch = Stopwatch()..start();
    
    try {
      await _addToCartUseCase.execute(
        productId: productId,
        productName: productName,
        price: price,
        quantity: quantity,
      );
      
      stopwatch.stop();
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      final existingIndex = _items.indexWhere((item) => item.productId == productId);
      
      if (existingIndex != -1) {
        final existing = _items[existingIndex];
        _items[existingIndex] = CartItem(
          productId: existing.productId,
          productName: existing.productName,
          price: existing.price,
          quantity: existing.quantity + quantity,
          imageUrl: existing.imageUrl,
        );
      } else {
        _items.add(CartItem(
          productId: productId,
          productName: productName,
          price: price,
          quantity: quantity,
          imageUrl: '',
        ));
      }
      
      _loadingState = CartLoadingState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      stopwatch.stop();
      _errorMessage = 'Error al agregar al carrito: ${e.toString()}';
      _loadingState = CartLoadingState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeFromCart(String productId) async {
    _loadingState = CartLoadingState.loading;
    _errorMessage = null;
    notifyListeners();

    final stopwatch = Stopwatch()..start();
    
    try {
      await _cartRepository.removeFromCart(productId);
      
      stopwatch.stop();
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      _items.removeWhere((item) => item.productId == productId);
      
      _loadingState = CartLoadingState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      stopwatch.stop();
      _errorMessage = 'Error al eliminar del carrito: ${e.toString()}';
      _loadingState = CartLoadingState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      return removeFromCart(productId);
    }

    final index = _items.indexWhere((item) => item.productId == productId);
    if (index == -1) return false;

    final stopwatch = Stopwatch()..start();
    
    try {
      await _cartRepository.updateQuantity(productId, quantity);
      
      stopwatch.stop();
      
      final current = _items[index];
      _items[index] = CartItem(
        productId: current.productId,
        productName: current.productName,
        price: current.price,
        quantity: quantity,
        imageUrl: current.imageUrl,
      );
      
      notifyListeners();
      return true;
    } catch (e) {
      stopwatch.stop();
      _errorMessage = 'Error al actualizar cantidad: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<bool> clearCart() async {
    _loadingState = CartLoadingState.loading;
    _errorMessage = null;
    notifyListeners();

    final stopwatch = Stopwatch()..start();
    
    try {
      await _cartRepository.clearCart();
      
      stopwatch.stop();
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      _items.clear();
      
      _loadingState = CartLoadingState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      stopwatch.stop();
      _errorMessage = 'Error al vaciar el carrito: ${e.toString()}';
      _loadingState = CartLoadingState.error;
      notifyListeners();
      return false;
    }
  }

  int getQuantityForProduct(String productId) {
    try {
      return _items.firstWhere((item) => item.productId == productId).quantity;
    } catch (_) {
      return 0;
    }
  }

  bool isInCart(String productId) {
    return _items.any((item) => item.productId == productId);
  }
}