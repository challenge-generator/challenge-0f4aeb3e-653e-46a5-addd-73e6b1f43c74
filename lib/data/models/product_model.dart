import 'dart:convert';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int stock;
  final double rating;
  final String category;
  final Map<String, dynamic>? metadata;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stock,
    required this.rating,
    required this.category,
    this.metadata,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: _parseDouble(json['price']),
      imageUrl: json['imageUrl'] as String? ?? json['image_url'] as String? ?? '',
      stock: json['stock'] as int? ?? 0,
      rating: _parseDouble(json['rating']),
      category: json['category'] as String? ?? '',
      metadata: json['metadata'] as Map<String, dynamic>?,
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
      if (metadata != null) 'metadata': metadata,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  static ProductModel fromJsonString(String jsonString) {
    return ProductModel.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  ProductModel copyWith({
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
    return ProductModel(
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

  bool get isInStock => stock > 0;

  bool get isPopular => rating >= 4.5;

  bool get hasDiscount => metadata != null && metadata!['discount'] != null;

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, price: $price, stock: $stock, rating: $rating, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}