package lib.data.repositories;

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:retail_app/core/constants/app_constants.dart';
import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/domain/repositories/product_repository.dart';
import 'package:retail_app/data/datasources/product_remote_datasource.dart';
import 'package:retail_app/data/datasources/local_cache_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final LocalCacheDataSource localCacheDataSource;
  final SharedPreferences sharedPreferences;
  
  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localCacheDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<List<Product>> getProducts({bool forceRefresh = false}) async {
    try {
      if (!forceRefresh) {
        final cachedProducts = await localCacheDataSource.getCachedProducts();
        if (cachedProducts.isNotEmpty) {
          final lastCacheTime = sharedPreferences.getInt(
            PerformanceConstants.lastCacheUpdateKey,
          );
          if (lastCacheTime != null) {
            final cacheAge = DateTime.now().millisecondsSinceEpoch - lastCacheTime;
            final maxAgeMs = PerformanceConstants.cacheDurationInDays * 24 * 60 * 60 * 1000;
            if (cacheAge < maxAgeMs) {
              return cachedProducts;
            }
          }
        }
      }

      final remoteProducts = await remoteDataSource.getProducts();
      await localCacheDataSource.cacheProducts(remoteProducts);
      await sharedPreferences.setInt(
        PerformanceConstants.lastCacheUpdateKey,
        DateTime.now().millisecondsSinceEpoch,
      );
      return remoteProducts;
    } on DioException catch (e) {
      final cachedProducts = await localCacheDataSource.getCachedProducts();
      if (cachedProducts.isNotEmpty) {
        return cachedProducts;
      }
      throw _mapDioError(e);
    } catch (e) {
      throw ProductRepositoryException('Failed to fetch products: $e');
    }
  }

  @override
  Future<Product?> getProductById(String id) async {
    try {
      final cachedProducts = await localCacheDataSource.getCachedProducts();
      final cachedProduct = cachedProducts.where((p) => p.id == id).firstOrNull;
      if (cachedProduct != null) {
        return cachedProduct;
      }
      return await remoteDataSource.getProductById(id);
    } on DioException catch (e) {
      throw _mapDioError(e);
    } catch (e) {
      throw ProductRepositoryException('Failed to fetch product: $e');
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final allProducts = await getProducts();
      return allProducts.where((p) => p.category == category).toList();
    } catch (e) {
      throw ProductRepositoryException('Failed to fetch products by category: $e');
    }
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    try {
      final allProducts = await getProducts();
      final lowercaseQuery = query.toLowerCase();
      return allProducts.where((p) {
        return p.name.toLowerCase().contains(lowercaseQuery) ||
               p.description.toLowerCase().contains(lowercaseQuery) ||
               p.category.toLowerCase().contains(lowercaseQuery);
      }).toList();
    } catch (e) {
      throw ProductRepositoryException('Failed to search products: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    await localCacheDataSource.clearProductCache();
    await sharedPreferences.remove(PerformanceConstants.lastCacheUpdateKey);
    await sharedPreferences.remove(PerformanceConstants.cachedProductsKey);
  }

  Exception _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ProductRepositoryException('Connection timeout. Please check your internet connection.');
      case DioExceptionType.connectionError:
        return ProductRepositoryException('No internet connection. Please check your network settings.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        if (statusCode == 404) {
          return ProductRepositoryException('Products not found.');
        } else if (statusCode >= 500) {
          return ProductRepositoryException('Server error. Please try again later.');
        }
        return ProductRepositoryException('Request failed with status: $statusCode');
      default:
        return ProductRepositoryException('An unexpected error occurred: ${e.message}');
    }
  }
}

class ProductRepositoryException implements Exception {
  final String message;
  ProductRepositoryException(this.message);
  
  @override
  String toString() => 'ProductRepositoryException: $message';
}