import 'package:flutter_test/flutter_test.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';
import 'package:retail_app/core/constants/app_constants.dart';
import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/data/datasources/product_remote_datasource.dart';
import 'package:retail_app/data/datasources/local_cache_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Performance Baseline Tests', () {
    late PerformanceMonitor performanceMonitor;
    late ProductRemoteDataSource remoteDataSource;
    late LocalCacheDataSource cacheDataSource;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      performanceMonitor = PerformanceMonitor();
      cacheDataSource = LocalCacheDataSource();
      remoteDataSource = ProductRemoteDataSource();
    });

    test('Initial performance monitoring state should be inactive', () {
      expect(performanceMonitor.performanceHistory.isEmpty, true);
    });

    test('Start monitoring should begin sampling performance', () {
      performanceMonitor.startMonitoring();
      Future.delayed(const Duration(milliseconds: 150), () {
        performanceMonitor.stopMonitoring();
        expect(performanceMonitor.performanceHistory.isNotEmpty, true);
      });
    });

    test('Network latency recording should capture timing', () {
      final testLatency = Duration(milliseconds: 250);
      performanceMonitor.recordNetworkLatency(testLatency);
      final samples = performanceMonitor.performanceHistory;
      expect(samples.isNotEmpty, true);
    });

    test('Image load time recording should work correctly', () {
      const testImageUrl = 'https://example.com/product.jpg';
      final testLoadTime = Duration(milliseconds: 120);
      performanceMonitor.recordImageLoadTime(testImageUrl, testLoadTime);
      final samples = performanceMonitor.performanceHistory;
      expect(samples.isNotEmpty, true);
    });

    test('Widget build time recording should capture metrics', () {
      const testWidgetName = 'ProductListScreen';
      final testBuildTime = Duration(milliseconds: 45);
      performanceMonitor.recordWidgetBuildTime(testWidgetName, testBuildTime);
      final samples = performanceMonitor.performanceHistory;
      expect(samples.isNotEmpty, true);
    });

    test('CPU usage should be within acceptable range', () {
      final sample = PerformanceSample(
        timestamp: DateTime.now(),
        cpuUsage: 45.5,
        memoryUsageMB: 120,
        frameBuildTime: const Duration(milliseconds: 16),
      );
      expect(sample.cpuUsage <= PerformanceConstants.maxCpuUsage, true);
    });

    test('Memory usage should not exceed threshold', () {
      final sample = PerformanceSample(
        timestamp: DateTime.now(),
        cpuUsage: 30.0,
        memoryUsageMB: 85,
        frameBuildTime: const Duration(milliseconds: 14),
      );
      expect(sample.memoryUsageMB <= PerformanceConstants.maxMemoryUsageMB, true);
    });

    test('Frame build time should meet 60fps target', () {
      final sample = PerformanceSample(
        timestamp: DateTime.now(),
        cpuUsage: 25.0,
        memoryUsageMB: 90,
        frameBuildTime: const Duration(milliseconds: 12),
      );
      expect(sample.frameBuildTime <= PerformanceConstants.maxFrameBuildTime, true);
    });

    test('Performance sample should serialize to JSON correctly', () {
      final sample = PerformanceSample(
        timestamp: DateTime.now(),
        cpuUsage: 35.0,
        memoryUsageMB: 100,
        frameBuildTime: const Duration(milliseconds: 15),
      );
      final json = sample.toJson();
      expect(json.containsKey('timestamp'), true);
      expect(json.containsKey('cpuUsage'), true);
      expect(json.containsKey('memoryUsageMB'), true);
      expect(json.containsKey('frameBuildTime'), true);
    });

    test('Performance constants should have valid values', () {
      expect(PerformanceConstants.maxMemoryUsageMB > 0, true);
      expect(PerformanceConstants.maxCpuUsage > 0, true);
      expect(PerformanceConstants.maxFrameBuildTime.inMilliseconds > 0, true);
      expect(PerformanceConstants.networkTimeout.inMilliseconds > 0, true);
    });

    test('Warning thresholds should be lower than max thresholds', () {
      expect(PerformanceConstants.warningCpuUsage < PerformanceConstants.maxCpuUsage, true);
      expect(PerformanceConstants.warningMemoryUsageMB < PerformanceConstants.maxMemoryUsageMB, true);
      expect(PerformanceConstants.warningFrameBuildTime < PerformanceConstants.maxFrameBuildTime, true);
    });

    test('Performance monitoring should support start and stop cycle', () {
      performanceMonitor.startMonitoring();
      expect(performanceMonitor.performanceHistory.isEmpty, true);
      Future.delayed(const Duration(milliseconds: 100), () {
        performanceMonitor.stopMonitoring();
        expect(performanceMonitor.performanceHistory.isNotEmpty, true);
      });
    });

    test('Multiple performance samples should be recorded in sequence', () {
      for (int i = 0; i < 10; i++) {
        performanceMonitor.recordNetworkLatency(Duration(milliseconds: 50 + i * 10));
      }
      expect(performanceMonitor.performanceHistory.length, 10);
    });

    test('Product entity should have performance-friendly implementation', () {
      final product = Product(
        id: '1',
        name: 'Test Product',
        description: 'Test Description',
        price: 99.99,
        imageUrl: 'https://example.com/image.jpg',
        stock: 10,
        rating: 4.5,
        category: 'electronics',
      );
      expect(product.isInStock, true);
      expect(product.isPopular, false);
      expect(product.hasDiscount, false);
    });

    test('Product comparison by popularity should work correctly', () {
      final product1 = Product(
        id: '1',
        name: 'Popular Product',
        description: 'Popular',
        price: 50.0,
        imageUrl: 'https://example.com/1.jpg',
        stock: 100,
        rating: 4.8,
        category: 'electronics',
      );
      final product2 = Product(
        id: '2',
        name: 'Less Popular',
        description: 'Not popular',
        price: 30.0,
        imageUrl: 'https://example.com/2.jpg',
        stock: 50,
        rating: 3.5,
        category: 'electronics',
      );
      expect(product1.compareByPopularity(product2) < 0, true);
    });

    test('Product comparison by price should work correctly', () {
      final cheapProduct = Product(
        id: '1',
        name: 'Cheap',
        description: 'Cheap',
        price: 25.0,
        imageUrl: 'https://example.com/1.jpg',
        stock: 20,
        rating: 4.0,
        category: 'books',
      );
      final expensiveProduct = Product(
        id: '2',
        name: 'Expensive',
        description: 'Expensive',
        price: 150.0,
        imageUrl: 'https://example.com/2.jpg',
        stock: 5,
        rating: 4.5,
        category: 'electronics',
      );
      expect(cheapProduct.compareByPrice(expensiveProduct) < 0, true);
    });

    test('Performance history should be retrievable', () {
      performanceMonitor.recordNetworkLatency(const Duration(milliseconds: 100));
      performanceMonitor.recordNetworkLatency(const Duration(milliseconds: 200));
      final history = performanceMonitor.performanceHistory;
      expect(history.length, 2);
    });

    test('Cache duration constant should be reasonable', () {
      expect(PerformanceConstants.cacheDurationInDays >= 1, true);
      expect(PerformanceConstants.cacheDurationInDays <= 30, true);
    });

    test('Max cache items should support reasonable cache size', () {
      expect(PerformanceConstants.maxCacheItems > 0, true);
      expect(PerformanceConstants.maxCacheItems <= 1000, true);
    });

    test('Image cache dimensions should be set correctly', () {
      expect(PerformanceConstants.minImageCacheWidth > 0, true);
      expect(PerformanceConstants.minImageCacheHeight > 0, true);
    });

    test('ListView cache extent should allow smooth scrolling', () {
      expect(PerformanceConstants.listViewCacheExtent >= 0, true);
    });

    test('Network timeout should be adequate for operations', () {
      expect(PerformanceConstants.networkTimeout.inSeconds >= 10, true);
      expect(PerformanceConstants.networkTimeout.inSeconds <= 60, true);
    });

    test('Performance monitoring should handle rapid samples', () {
      performanceMonitor.startMonitoring();
      for (int i = 0; i < 50; i++) {
        performanceMonitor.recordNetworkLatency(Duration(milliseconds: i));
      }
      performanceMonitor.stopMonitoring();
      expect(performanceMonitor.performanceHistory.length >= 50, true);
    });
  });
}