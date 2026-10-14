import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/cart_item.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../widgets/optimized_image.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/performance_monitor.dart';
import 'product_detail_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final PerformanceMonitor _performanceMonitor = PerformanceMonitor();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _performanceMonitor.recordWidgetBuildTime('CartScreen', Duration.zero);
    });
  }

  double get _totalPrice {
    final viewModel = context.read<CartViewModel>();
    return viewModel.totalPrice;
  }

  int get _totalItems {
    final viewModel = context.read<CartViewModel>();
    return viewModel.totalItems;
  }

  Future<void> _checkout() async {
    final viewModel = context.read<CartViewModel>();
    
    try {
      await viewModel.clearCart();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Pedido realizado con éxito'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al procesar el pedido: $e'),
            backgroundColor: UiConstants.errorColor,
          ),
        );
      }
    }
  }

  void _updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity <= 0) {
      _removeItem(item);
      return;
    }
    
    final viewModel = context.read<CartViewModel>();
    final updatedItem = CartItem(
      productId: item.productId,
      product: item.product,
      quantity: newQuantity,
    );
    viewModel.updateQuantity(updatedItem);
  }

  void _removeItem(CartItem item) {
    final viewModel = context.read<CartViewModel>();
    viewModel.removeFromCart(item.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Carrito de compras'),
        backgroundColor: UiConstants.primaryColor,
        foregroundColor: UiConstants.onPrimaryColor,
        elevation: UiConstants.defaultElevation,
        actions: [
          Consumer<CartViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.items.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.delete_sweep),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Vaciar carrito'),
                        content: const Text(
                          '¿Estás seguro de que quieres eliminar todos los productos?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              viewModel.clearCart();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Eliminar',
                              style: TextStyle(color: UiConstants.errorColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<CartViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: UiConstants.primaryColor,
              ),
            );
          }

          if (viewModel.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: UiConstants.onBackgroundColor.withOpacity(0.3),
                  ),
                  const SizedBox(height: UiConstants.defaultPadding),
                  Text(
                    'Tu carrito está vacío',
                    style: TextStyle(
                      fontSize: UiConstants.titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: UiConstants.onBackgroundColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Añade productos para comenzar',
                    style: TextStyle(
                      fontSize: UiConstants.subtitleFontSize,
                      color: UiConstants.onBackgroundColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UiConstants.primaryColor,
                      foregroundColor: UiConstants.onPrimaryColor,
                    ),
                    child: const Text('Continuar comprando'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(UiConstants.defaultPadding),
                  itemCount: viewModel.items.length,
                  itemBuilder: (context, index) {
                    final item = viewModel.items[index];
                    return _CartItemCard(
                      item: item,
                      onQuantityChanged: (quantity) => _updateQuantity(item, quantity),
                      onRemove: () => _removeItem(item),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              product: item.product,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total (${\_totalItems} productos)',
                            style: TextStyle(
                              fontSize: UiConstants.subtitleFontSize,
                              color: UiConstants.onSurfaceColor,
                            ),
                          ),
                          Text(
                            '\$${\_totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: UiConstants.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _checkout,
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_bag),
                              SizedBox(width: 8),
                              Text(
                                'Proceder al pago',
                                style: TextStyle(
                                  fontSize: UiConstants.defaultFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem item;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const _CartItemCard({
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: UiConstants.defaultPadding),
      elevation: UiConstants.defaultElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiConstants.defaultBorderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UiConstants.defaultBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(UiConstants.defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: OptimizedImage(
                  imageUrl: item.product.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.name,
                      style: TextStyle(
                        fontSize: UiConstants.defaultFontSize,
                        fontWeight: FontWeight.bold,
                        color: UiConstants.onSurfaceColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${item.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: UiConstants.subtitleFontSize,
                        color: UiConstants.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: UiConstants.primaryColor.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () => onQuantityChanged(item.quantity - 1),
                                child: const Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Icon(Icons.remove, size: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  item.quantity.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: UiConstants.onSurfaceColor,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => onQuantityChanged(item.quantity + 1),
                                child: const Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Icon(Icons.add, size: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: UiConstants.errorColor,
                          ),
                          onPressed: onRemove,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}