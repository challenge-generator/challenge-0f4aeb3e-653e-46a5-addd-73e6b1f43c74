import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int stock;
  final double rating;
  final String category;
  final Map<String, dynamic>? metadata;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stock,
    required this.rating,
    required this.category,
    this.metadata,
  }) {
    // Validaciones básicas
    if (price < 0) {
      throw ArgumentError('Price cannot be negative');
    }
    if (stock < 0) {
      throw ArgumentError('Stock cannot be negative');
    }
    if (rating < 0 || rating > 5) {
      throw ArgumentError('Rating must be between 0 and 5');
    }
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    int? stock,
    double? rating,
    String? category,
    Map<String, dynamic>? metadata,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      category: category ?? this.category,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'stock': stock,
      'rating': rating,
      'category': category,
      'metadata': metadata,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      stock: json['stock'] as int,
      rating: (json['rating'] as num).toDouble(),
      category: json['category'] as String,
      metadata: json['metadata'] != null
          ? Map<String, dynamic>.from(json['metadata'])
          : null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ price.hashCode;
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, stock: $stock)';
  }

  // Métodos adicionales para lógica de negocio
  bool get isInStock => stock > 0;

  bool get isPopular => rating >= 4.0;

  String get formattedPrice {
    return '$${price.toStringAsFixed(2)}';
  }

  String get stockStatus {
    if (stock > 50) return 'En stock';
    if (stock > 0) return 'Pocos disponibles';
    return 'Agotado';
  }

  // Propiedades calculadas para optimización
  double get discountPercentage {
    return metadata?['discount'] != null
        ? (metadata!['discount'] as num).toDouble()
        : 0.0;
  }

  double get finalPrice {
    return price * (1 - discountPercentage / 100);
  }

  String get formattedFinalPrice {
    return '$${finalPrice.toStringAsFixed(2)}';
  }

  bool get hasDiscount => discountPercentage > 0;

  // Método para comparar productos por popularidad
  int compareByPopularity(Product other) {
    return other.rating.compareTo(rating);
  }

  // Método para comparar productos por precio
  int compareByPrice(Product other) {
    return price.compareTo(other.price);
  }
}