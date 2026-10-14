package retail_app.domain.usecases;

import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/domain/repositories/product_repository.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';
import 'package:retail_app/core/constants/app_constants.dart';

class GetProductsUseCase {
  final ProductRepository _productRepository;
  final PerformanceMonitor _performanceMonitor;
  
  GetProductsUseCase({
    required ProductRepository productRepository,
    required PerformanceMonitor performanceMonitor,
  })  : _productRepository = productRepository,
        _performanceMonitor = performanceMonitor;

  Future<List<Product>> execute({
    bool forceRefresh = false,
    int? limit,
    String? category,
  }) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final cacheDuration = Duration(
        days: PerformanceConstants.cacheDurationInDays,
      );
      
      final products = await _productRepository.getProducts(
        forceRefresh: forceRefresh,
        limit: limit ?? PerformanceConstants.productPageSize,
        category: category,
      );
      
      stopwatch.stop();
      
      final loadTime = stopwatch.elapsed;
      _performanceMonitor.recordNetworkLatency(loadTime);
      
      if (loadTime > PerformanceConstants.maxNetworkLatency) {
        _performanceMonitor._checkPerformanceAlerts(
          PerformanceSample(
            timestamp: DateTime.now(),
            cpuUsage: _performanceMonitor._getCpuUsage(),
            memoryUsageMB: _performanceMonitor._getMemoryUsage(),
            frameBuildTime: _performanceMonitor._getFrameBuildTime(),
          ),
        );
      }
      
      return _sortProductsByRelevance(products);
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  List<Product> _sortProductsByRelevance(List<Product> products) {
    final sorted = List<Product>.from(products);
    sorted.sort((a, b) => b.compareByPopularity(a));
    return sorted;
  }

  Future<Product?> getProductById(String productId) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final product = await _productRepository.getProductById(productId);
      
      stopwatch.stop();
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      return product;
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    if (query.isEmpty) {
      return execute();
    }
    
    final stopwatch = Stopwatch()..start();
    
    try {
      final allProducts = await _productRepository.getProducts(
        forceRefresh: false,
        limit: PerformanceConstants.initialProductLoadCount,
      );
      
      final filtered = allProducts.where((product) {
        final nameLower = product.name.toLowerCase();
        final descLower = product.description.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower) || 
               descLower.contains(queryLower) ||
               product.category.toLowerCase().contains(queryLower);
      }).toList();
      
      stopwatch.stop();
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      return filtered;
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }
}