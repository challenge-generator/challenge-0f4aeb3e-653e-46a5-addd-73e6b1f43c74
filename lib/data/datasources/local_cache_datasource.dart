import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

abstract class LocalCacheDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>?> getCachedProducts();
  Future<void> cacheProductDetail(ProductModel product);
  Future<ProductModel?> getCachedProductDetail(String productId);
  Future<void> cacheLastUpdateTime(DateTime time);
  Future<DateTime?> getLastUpdateTime();
  Future<bool> isCacheValid({int maxAgeInDays = 7});
  Future<void> clearCache();
  Future<void> clearProductCache();
  Future<int> getCacheSize();
}

class LocalCacheDataSourceImpl implements LocalCacheDataSource {
  final SharedPreferences sharedPreferences;
  static const String _cachedProductsKey = 'cached_products';
  static const String _lastCacheUpdateKey = 'last_cache_update';
  static const String _productDetailPrefix = 'product_detail_';
  static const int _maxCacheItems = 100;

  LocalCacheDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    try {
      final limitedProducts = products.length > _maxCacheItems
          ? products.sublist(0, _maxCacheItems)
          : products;
      
      final jsonList = limitedProducts.map((p) => p.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      
      await sharedPreferences.setString(_cachedProductsKey, jsonString);
      await cacheLastUpdateTime(DateTime.now());
    } catch (e) {
      throw Exception('Failed to cache products: $e');
    }
  }

  @override
  Future<List<ProductModel>?> getCachedProducts() async {
    try {
      final jsonString = sharedPreferences.getString(_cachedProductsKey);
      if (jsonString == null || jsonString.isEmpty) {
        return null;
      }
      
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      await clearProductCache();
      return null;
    }
  }

  @override
  Future<void> cacheProductDetail(ProductModel product) async {
    try {
      final key = '$_productDetailPrefix${product.id}';
      final jsonString = jsonEncode(product.toJson());
      await sharedPreferences.setString(key, jsonString);
    } catch (e) {
      throw Exception('Failed to cache product detail: $e');
    }
  }

  @override
  Future<ProductModel?> getCachedProductDetail(String productId) async {
    try {
      final key = '$_productDetailPrefix$productId';
      final jsonString = sharedPreferences.getString(key);
      if (jsonString == null || jsonString.isEmpty) {
        return null;
      }
      
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return ProductModel.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheLastUpdateTime(DateTime time) async {
    try {
      final timestamp = time.toIso8601String();
      await sharedPreferences.setString(_lastCacheUpdateKey, timestamp);
    } catch (e) {
      throw Exception('Failed to cache update time: $e');
    }
  }

  @override
  Future<DateTime?> getLastUpdateTime() async {
    try {
      final timestamp = sharedPreferences.getString(_lastCacheUpdateKey);
      if (timestamp == null || timestamp.isEmpty) {
        return null;
      }
      return DateTime.parse(timestamp);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> isCacheValid({int maxAgeInDays = 7}) async {
    try {
      final lastUpdate = await getLastUpdateTime();
      if (lastUpdate == null) {
        return false;
      }
      
      final now = DateTime.now();
      final difference = now.difference(lastUpdate);
      return difference.inDays < maxAgeInDays;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final keys = sharedPreferences.getKeys();
      final keysToRemove = keys.where((key) =>
          key == _cachedProductsKey ||
          key == _lastCacheUpdateKey ||
          key.startsWith(_productDetailPrefix)).toList();
      
      await sharedPreferences.remove(_cachedProductsKey);
      await sharedPreferences.remove(_lastCacheUpdateKey);
      
      for (final key in keysToRemove) {
        if (key.startsWith(_productDetailPrefix)) {
          await sharedPreferences.remove(key);
        }
      }
    } catch (e) {
      throw Exception('Failed to clear cache: $e');
    }
  }

  @override
  Future<void> clearProductCache() async {
    try {
      await sharedPreferences.remove(_cachedProductsKey);
      await sharedPreferences.remove(_lastCacheUpdateKey);
    } catch (e) {
      throw Exception('Failed to clear product cache: $e');
    }
  }

  @override
  Future<int> getCacheSize() async {
    try {
      final products = await getCachedProducts();
      return products?.length ?? 0;
    } catch (e) {
      return 0;
    }
  }
}