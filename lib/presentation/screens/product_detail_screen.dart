import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';
import '../viewmodels/product_viewmodel.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../widgets/optimized_image.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/performance_monitor.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  final PerformanceMonitor _performanceMonitor = PerformanceMonitor();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _performanceMonitor.recordWidgetBuildTime('ProductDetailScreen', Duration.zero);
    });
  }

  void _incrementQuantity() {
    if (_quantity < widget.product.stock) {
      setState(() {
        _quantity++;
      });
    }
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  Future<void> _addToCart() async {
    final cartViewModel = context.read<CartViewModel>();
    final cartItem = CartItem(
      productId: widget.product.id,
      product: widget.product,
      quantity: _quantity,
    );

    try {
      await cartViewModel.addToCart(cartItem);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${widget.product.name} añadido al carrito'),
            backgroundColor: UiConstants.primaryColor,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al añadir al carrito: $e'),
            backgroundColor: UiConstants.errorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth * 0.7;

    return Scaffold(
      backgroundColor: UiConstants.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: imageHeight,
            pinned: true,
            backgroundColor: UiConstants.primaryColor,
            foregroundColor: UiConstants.onPrimaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product_image_${widget.product.id}',
                child: OptimizedImage(
                  imageUrl: widget.product.imageUrl,
                  width: screenWidth,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // Implementar compartir
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: {
                  // Implementar favorito
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(UiConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: UiConstants.titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: UiConstants.onBackgroundColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: UiConstants.defaultIconSize,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.product.rating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: UiConstants.defaultFontSize,
                          fontWeight: FontWeight.w500,
                          color: UiConstants.onBackgroundColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: widget.product.isInStock
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.product.isInStock
                              ? 'En stock (${widget.product.stock})'
                              : 'Sin stock',
                          style: TextStyle(
                            fontSize: 12,
                            color: widget.product.isInStock
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: UiConstants.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: UiConstants.defaultFontSize,
                      color: UiConstants.onBackgroundColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Categoría: ${widget.product.category}',
                    style: TextStyle(
                      fontSize: UiConstants.subtitleFontSize,
                      color: UiConstants.onBackgroundColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Text(
                        'Cantidad:',
                        style: TextStyle(
                          fontSize: UiConstants.defaultFontSize,
                          fontWeight: FontWeight.w500,
                          color: UiConstants.onBackgroundColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: UiConstants.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            UiConstants.defaultBorderRadius,
                          ),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: _decrementQuantity,
                              color: UiConstants.primaryColor,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                _quantity.toString(),
                                style: TextStyle(
                                  fontSize: UiConstants.defaultFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: UiConstants.onBackgroundColor,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: _incrementQuantity,
                              color: UiConstants.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(UiConstants.defaultPadding),
        decoration: BoxDecoration(
          color: UiConstants.surfaceColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: widget.product.isInStock ? _addToCart : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: UiConstants.primaryColor,
              foregroundColor: UiConstants.onPrimaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  UiConstants.defaultBorderRadius,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_cart),
                const SizedBox(width: 8),
                Text(
                  'Añadir al carrito (\$${(widget.product.price * _quantity).toStringAsFixed(2)})',
                  style: const TextStyle(
                    fontSize: UiConstants.defaultFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}