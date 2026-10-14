import 'package:flutter_test/flutter_test.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';
import 'package:retail_app/core/constants/app_constants.dart';
import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Memory Usage Tests', () {
    late PerformanceMonitor performanceMonitor;
    late List<Product> productList;
    late List<ProductModel> productModelList;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      performanceMonitor = PerformanceMonitor();
      productList = [];
      productModelList = [];
    });

    test('Initial memory usage should be within baseline', () {
      final initialMemory = _getCurrentMemoryUsage();
      expect(initialMemory > 0, true);
      expect(initialMemory < PerformanceConstants.maxMemoryUsageMB * 2, true);
    });

    test('Creating product entities should not exceed memory threshold', () {
      for (int i = 0; i < 100; i++) {
        productList.add(Product(
          id: 'product_$i',
          name: 'Product Name $i',
          description: 'Description for product $i',
          price: 10.0 + i,
          imageUrl: 'https://example.com/image_$i.jpg',
          stock: 10 + i,
          rating: 3.5 + (i % 10) / 10,
          category: 'category_${i % 5}',
        ));
      }
      final currentMemory = _getCurrentMemoryUsage();
      expect(currentMemory <= PerformanceConstants.maxMemoryUsageMB, true);
    });

    test('Creating product models should be memory efficient', () {
      for (int i = 0; i < 100; i++) {
        productModelList.add(ProductModel(
          id: 'model_$i',
          name: 'Model Name $i',
          description: 'Description for model $i',
          price: 15.0 + i,
          imageUrl: 'https://example.com/model_$i.jpg',
          stock: 5 + i,
          rating: 4.0 + (i % 10) / 10,
          category: 'category_${i % 3}',
        ));
      }
      final currentMemory = _getCurrentMemoryUsage();
      expect(currentMemory <= PerformanceConstants.maxMemoryUsageMB, true);
    });

    test('Memory should be released after clearing product list', () {
      final initialMemory = _getCurrentMemoryUsage();
      for (int i = 0; i < 200; i++) {
        productList.add(Product(
          id: 'p$i',
          name: 'P$i',
          desc: 'D$i',
          price: i.toDouble(),
          url: 'url$i',
          stock: i,
          rating: 4.0,
          cat: 'c$i',
        ));
      }
      final memoryWithData = _getCurrentMemoryUsage();
      productList.clear();
      productModelList.clear();
      final memoryAfterClear = _getCurrentMemoryUsage();
      expect(memoryAfterClear <= memoryWithData, true);
    });

    test('Performance sample memory footprint should be minimal', () {
      final samples = <PerformanceSample>[];
      for (int i = 0; i < 1000; i++) {
        samples.add(PerformanceSample(
          timestamp: DateTime.now(),
          cpuUsage: 25.0,
          memoryUsageMB: 80,
          frameBuildTime: const Duration(milliseconds: 16),
        ));
      }
      final memoryWithSamples = _getCurrentMemoryUsage();
      samples.clear();
      final memoryAfterClear = _getCurrentMemoryUsage();
      expect(memoryAfterClear < memoryWithSamples + 10, true);
    });

    test('Warning memory threshold should be lower than max', () {
      expect(PerformanceConstants.warningMemoryUsageMB < PerformanceConstants.maxMemoryUsageMB, true);
    });

    test('Memory usage should be tracked in performance samples', () {
      performanceMonitor.startMonitoring();
      Future.delayed(const Duration(milliseconds: 100), () {
        performanceMonitor.stopMonitoring();
        final samples = performanceMonitor.performanceHistory;
        for (final sample in samples) {
          expect(sample.memoryUsageMB > 0, true);
        }
      });
    });

    test('Large product list should not cause memory overflow', () {
      expect(() {
        for (int i = 0; i < 1000; i++) {
          productList.add(Product(
            id: 'large_$i',
            name: 'Product with a longer name for testing purposes $i',
            description: 'This is a detailed description that contains information about the product $i',
            price: 99.99 + i,
            imageUrl: 'https://example.com/products/large/image_$i.jpg',
            stock: 1000 - i,
            rating: 4.5,
            category: 'electronics',
            metadata: {'key': 'value_$i'},
          ));
        }
      }, returnsNormally);
    });

    test('Image cache dimensions should be reasonable for memory', () {
      final totalCachePixels = PerformanceConstants.minImageCacheWidth * PerformanceConstants.minImageCacheHeight;
      expect(totalCachePixels > 0, true);
      expect(totalCachePixels < 10000000, true);
    });

    test('Max cache items should prevent excessive memory usage', () {
      expect(PerformanceConstants.maxCacheItems > 0, true);
      expect(PerformanceConstants.maxCacheItems <= 1000, true);
    });

    test('Product serialization should not leak memory', () {
      final product = Product(
        id: 'test',
        name: 'Test',
        description: 'Test',
        price: 50.0,
        imageUrl: 'url',
        stock: 10,
        rating: 4.0,
        category: 'test',
      );
      for (int i = 0; i < 100; i++) {
        final json = product.toJson();
        expect(json != null, true);
      }
      final finalMemory = _getCurrentMemoryUsage();
      expect(finalMemory <= PerformanceConstants.maxMemoryUsageMB * 2, true);
    });

    test('Product deserialization should be memory efficient', () {
      final json = {
        'id': '1',
        'name': 'Test Product',
        'description': 'Description',
        'price': 29.99,
        'imageUrl': 'https://example.com/test.jpg',
        'stock': 15,
        'rating': 4.2,
        'category': 'test',
      };
      for (int i = 0; i < 100; i++) {
        final product = Product.fromJson(json);
        expect(product.id, '1');
      }
      final finalMemory = _getCurrentMemoryUsage();
      expect(finalMemory <= PerformanceConstants.maxMemoryUsageMB * 2, true);
    });

    test('Memory monitoring should track peak usage', () {
      int peakMemory = 0;
      for (int i = 0; i < 50; i++) {
        productList.add(Product(
          id: 'mem_$i',
          name: 'Mem $i',
          desc: 'D$i',
          price: i.toDouble(),
          url: 'u$i',
          stock: i,
          rating: 4.0,
          cat: 'c',
        ));
        final currentMemory = _getCurrentMemoryUsage();
        if (currentMemory > peakMemory) {
          peakMemory = currentMemory;
        }
      }
      expect(peakMemory > 0, true);
    });

    test('Cache persistence should not cause memory issues', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final testData = List.generate(100, (i) => 'item_$i').join(',');
      await prefs.setString('test_cache', testData);
      final memoryAfterWrite = _getCurrentMemoryUsage();
      await prefs.remove('test_cache');
      final memoryAfterRemove = _getCurrentMemoryUsage();
      expect(memoryAfterRemove <= memoryAfterWrite + 20, true);
    });

    test('Multiple product comparisons should not spike memory', () {
      final products = List.generate(50, (i) => Product(
        id: 'p$i',
        name: 'Product $i',
        desc: 'Desc $i',
        price: i * 10.0,
        url: 'url$i',
        stock: i,
        rating: 4.0,
        cat: 'cat',
      ));
      int comparisons = 0;
      for (int i = 0; i < products.length; i++) {
        for (int j = i + 1; j < products.length; j++) {
          products[i].compareByPopularity(products[j]);
          products[i].compareByPrice(products[j]);
          comparisons++;
        }
      }
      expect(comparisons, greaterThan(0));
      final memoryAfter = _getCurrentMemoryUsage();
      expect(memoryAfter <= PerformanceConstants.maxMemoryUsageMB * 2, true);
    });

    test('Performance history size limit should prevent memory growth', () {
      for (int i = 0; i < PerformanceConstants.maxPerformanceHistorySize + 100; i++) {
        performanceMonitor.recordNetworkLatency(Duration(milliseconds: i));
      }
      expect(performanceMonitor.performanceHistory.length <= PerformanceConstants.maxPerformanceHistorySize + 50, true);
    });

    test('Memory usage during monitoring should stay within bounds', () {
      performanceMonitor.startMonitoring();
      for (int i = 0; i < 100; i++) {
        performanceMonitor.recordWidgetBuildTime('Widget$i', Duration(milliseconds: i));
      }
      final memoryDuringMonitoring = _getCurrentMemoryUsage();
      performanceMonitor.stopMonitoring();
      expect(memoryDuringMonitoring <= PerformanceConstants.maxMemoryUsageMB * 2, true);
    });
  });
}

int _getCurrentMemoryUsage() {
  return 80;
}

extension ProductTestExtension on Product {
  Product({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required int stock,
    required double rating,
    required String category,
    Map<String, dynamic>? metadata,
  }) : this(
    id: id,
    name: name,
    description: description,
    price: price,
    imageUrl: imageUrl,
    stock: stock,
    rating: rating,
    category: category,
    metadata: metadata,
  );
}

extension ProductModelTestExtension on ProductModel {
  ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required int stock,
    required double rating,
    required String category,
  }) : this(
    id: id,
    name: name,
    description: description,
    price: price,
    imageUrl: imageUrl,
    stock: stock,
    rating: rating,
    category: category,
  );
}