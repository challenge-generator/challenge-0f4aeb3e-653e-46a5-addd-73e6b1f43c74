package retail_app.presentation.viewmodels;

import 'package:flutter/foundation.dart';
import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/domain/repositories/product_repository.dart';
import 'package:retail_app/domain/usecases/get_products_usecase.dart';
import 'package:retail_app/core/constants/app_constants.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';

enum ProductLoadingState { initial, loading, loaded, error }

enum ProductSortOption { none, priceAsc, priceDesc, popularity, rating }

class ProductViewModel extends ChangeNotifier {
  final GetProductsUseCase _getProductsUseCase;
  final ProductRepository _productRepository;
  final PerformanceMonitor _performanceMonitor;

  ProductViewModel({
    required GetProductsUseCase getProductsUseCase,
    required ProductRepository productRepository,
    PerformanceMonitor? performanceMonitor,
  })  : _getProductsUseCase = getProductsUseCase,
        _productRepository = productRepository,
        _performanceMonitor = performanceMonitor ?? PerformanceMonitor();

  ProductLoadingState _loadingState = ProductLoadingState.initial;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String? _errorMessage;
  String _searchQuery = '';
  String? _selectedCategory;
  ProductSortOption _sortOption = ProductSortOption.none;
  bool _hasMoreProducts = true;
  int _currentPage = 0;
  final int _pageSize = PerformanceConstants.productPageSize;

  ProductLoadingState get loadingState => _loadingState;
  
  List<Product> get products => _filteredProducts;
  
  String? get errorMessage => _errorMessage;
  
  bool get hasMoreProducts => _hasMoreProducts;
  
  bool get isLoading => _loadingState == ProductLoadingState.loading;
  
  String get searchQuery => _searchQuery;
  
  String? get selectedCategory => _selectedCategory;
  
  ProductSortOption get sortOption => _sortOption;

  Set<String> get availableCategories {
    final categories = _products.map((p) => p.category).toSet();
    return categories..removeWhere((c) => c.isEmpty);
  }

  Future<void> loadProducts({bool refresh = false}) async {
    if (_loadingState == ProductLoadingState.loading) return;
    
    _loadingState = ProductLoadingState.loading;
    _errorMessage = null;
    if (refresh) {
      _currentPage = 0;
      _hasMoreProducts = true;
    }
    notifyListeners();

    final stopwatch = Stopwatch()..start();
    
    try {
      _products = await _getProductsUseCase.execute();
      stopwatch.stop();
      
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      _applyFiltersAndSort();
      _loadingState = ProductLoadingState.loaded;
    } catch (e) {
      stopwatch.stop();
      _errorMessage = 'Error al cargar productos: ${e.toString()}';
      _loadingState = ProductLoadingState.error;
    }
    
    notifyListeners();
  }

  Future<void> loadMoreProducts() async {
    if (!_hasMoreProducts || _loadingState == ProductLoadingState.loading) {
      return;
    }

    _currentPage++;
    final startIndex = _currentPage * _pageSize;
    final endIndex = (startIndex + _pageSize).clamp(0, _products.length);

    if (startIndex >= _products.length) {
      _hasMoreProducts = false;
      notifyListeners();
      return;
    }

    final newProducts = _products.sublist(startIndex, endIndex);
    _filteredProducts = [..._filteredProducts, ...newProducts];
    _hasMoreProducts = endIndex < _products.length;
    
    notifyListeners();
  }

  void setSearchQuery(String query) {
    if (_searchQuery == query) return;
    
    _searchQuery = query;
    _applyFiltersAndSort();
    notifyListeners();
  }

  void setCategory(String? category) {
    if (_selectedCategory == category) return;
    
    _selectedCategory = category;
    _applyFiltersAndSort();
    notifyListeners();
  }

  void setSortOption(ProductSortOption option) {
    if (_sortOption == option) return;
    
    _sortOption = option;
    _applyFiltersAndSort();
    notifyListeners();
  }

  void _applyFiltersAndSort() {
    final stopwatch = Stopwatch()..start();
    
    List<Product> result = List.from(_products);

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      result = result.where((p) =>
          p.name.toLowerCase().contains(query) ||
          p.description.toLowerCase().contains(query) ||
          p.category.toLowerCase().contains(query)).toList();
    }

    if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
      result = result.where((p) => p.category == _selectedCategory).toList();
    }

    switch (_sortOption) {
      case ProductSortOption.priceAsc:
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case ProductSortOption.priceDesc:
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case ProductSortOption.popularity:
        result.sort((a, b) => b.compareByPopularity(a));
        break;
      case ProductSortOption.rating:
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case ProductSortOption.none:
        break;
    }

    stopwatch.stop();
    _performanceMonitor.recordWidgetBuildTime('ProductViewModel_filter', stopwatch.elapsed);
    
    _filteredProducts = result;
    _hasMoreProducts = result.length > _pageSize;
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _sortOption = ProductSortOption.none;
    _applyFiltersAndSort();
    notifyListeners();
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  void refreshProduct(String productId) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      notifyListeners();
    }
  }
}