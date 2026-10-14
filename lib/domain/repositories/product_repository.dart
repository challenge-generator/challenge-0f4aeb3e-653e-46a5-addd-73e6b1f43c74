package lib.domain.repositories;

import 'package:retail_app/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({
    int page = 1,
    int pageSize = 20,
    String? category,
    String? searchQuery,
    ProductSortOption sortBy = ProductSortOption.popularity,
    bool descending = false,
  });

  Future<Product?> getProductById(String id);

  Future<List<Product>> getProductsByCategory(String category, {int? limit});

  Future<List<Product>> searchProducts(String query, {int? limit});

  Future<List<String>> getCategories();

  Future<List<Product>> getFeaturedProducts({int limit = 10});

  Future<List<Product>> getPopularProducts({int limit = 20});

  Future<List<Product>> getRelatedProducts(String productId, {int limit = 5});

  Future<void> refreshProducts();

  Future<bool> isCacheValid();

  Future<void> clearCache();
}

enum ProductSortOption {
  popularity,
  price,
  rating,
  newest,
  name,
}

extension ProductSortOptionExtension on ProductSortOption {
  String get displayName {
    switch (this) {
      case ProductSortOption.popularity:
        return 'Popularidad';
      case ProductSortOption.price:
        return 'Precio';
      case ProductSortOption.rating:
        return 'Calificación';
      case ProductSortOption.newest:
        return 'Más reciente';
      case ProductSortOption.name:
        return 'Nombre';
    }
  }

  String get apiParameter {
    switch (this) {
      case ProductSortOption.popularity:
        return 'popularity';
      case ProductSortOption.price:
        return 'price';
      case ProductSortOption.rating:
        return 'rating';
      case ProductSortOption.newest:
        return 'created_at';
      case ProductSortOption.name:
        return 'name';
    }
  }
}

class ProductRepositoryException implements Exception {
  final String message;
  final ProductRepositoryErrorType type;
  final dynamic originalError;

  const ProductRepositoryException({
    required this.message,
    required this.type,
    this.originalError,
  });

  @override
  String toString() => 'ProductRepositoryException: $message (type: $type)';

  bool get isNetworkError => type == ProductRepositoryErrorType.networkError;
  bool get isCacheError => type == ProductRepositoryErrorType.cacheError;
  bool get isNotFound => type == ProductRepositoryErrorType.notFound;
}

enum ProductRepositoryErrorType {
  networkError,
  cacheError,
  notFound,
  invalidData,
  unknown,
}

class ProductFilter {
  final String? category;
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final bool? inStockOnly;
  final List<String>? tags;

  const ProductFilter({
    this.category,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.inStockOnly,
    this.tags,
  });

  bool get hasFilters =>
      category != null ||
      minPrice != null ||
      maxPrice != null ||
      minRating != null ||
      inStockOnly == true ||
      (tags != null && tags!.isNotEmpty);

  ProductFilter copyWith({
    String? category,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    bool? inStockOnly,
    List<String>? tags,
  }) {
    return ProductFilter(
      category: category ?? this.category,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      inStockOnly: inStockOnly ?? this.inStockOnly,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};
    if (category != null) params['category'] = category;
    if (minPrice != null) params['min_price'] = minPrice;
    if (maxPrice != null) params['max_price'] = maxPrice;
    if (minRating != null) params['min_rating'] = minRating;
    if (inStockOnly != null) params['in_stock'] = inStockOnly;
    if (tags != null && tags!.isNotEmpty) params['tags'] = tags!.join(',');
    return params;
  }
}

class ProductPagination {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const ProductPagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  int get nextPage => hasNextPage ? currentPage + 1 : currentPage;
  int get previousPage => hasPreviousPage ? currentPage - 1 : currentPage;

  String get paginationInfo => 'Página $currentPage de $totalPages ($totalItems productos)';
}