package retail_app.presentation.widgets;

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/domain/entities/cart_item.dart';
import 'package:retail_app/presentation/viewmodels/cart_viewmodel.dart';
import 'package:retail_app/core/constants/app_constants.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final bool showAddToCartButton;
  final bool compact;
  final PerformanceMonitor? performanceMonitor;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.showAddToCartButton = true,
    this.compact = false,
    this.performanceMonitor,
  });

  @override
  Widget build(BuildContext context) {
    final stopwatch = Stopwatch()..start();
    
    final card = _buildCard(context);
    
    stopwatch.stop();
    performanceMonitor?.recordWidgetBuildTime('ProductCard_${product.id}', stopwatch.elapsed);
    
    return card;
  }

  Widget _buildCard(BuildContext context) {
    if (compact) {
      return _buildCompactCard(context);
    }
    return _buildFullCard(context);
  }

  Widget _buildFullCard(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: compact ? 1 : UiConstants.defaultElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiConstants.defaultBorderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: _buildImage(theme),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(UiConstants.defaultPadding * 0.75),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildName(theme),
                    const SizedBox(height: 4),
                    _buildCategory(theme),
                    const Spacer(),
                    _buildPriceRow(theme, context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactCard(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiConstants.defaultBorderRadius * 0.75),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UiConstants.defaultBorderRadius * 0.75),
        child: SizedBox(
          height: 80,
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: _buildImage(theme),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(UiConstants.defaultPadding * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: UiConstants.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (showAddToCartButton) _buildAddToCartButton(context, compact: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(ThemeData theme) {
    return CachedNetworkImage(
      imageUrl: product.imageUrl,
      fit: UiConstants.defaultImageBoxFit,
      filterQuality: PerformanceConstants.defaultImageFilterQuality,
      memCacheWidth: PerformanceConstants.minImageCacheWidth.toInt(),
      memCacheHeight: PerformanceConstants.minImageCacheHeight.toInt(),
      placeholder: (context, url) => Container(
        color: PerformanceConstants.placeholderColor.withValues(alpha: PerformanceConstants.placeholderOpacity),
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: PerformanceConstants.placeholderColor.withValues(alpha: PerformanceConstants.placeholderOpacity),
        child: Icon(
          Icons.broken_image_outlined,
          size: UiConstants.defaultIconSize,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }

  Widget _buildName(ThemeData theme) {
    return Text(
      product.name,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCategory(ThemeData theme) {
    return Text(
      product.category,
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPriceRow(ThemeData theme, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: theme.textTheme.titleMedium?.copyWith(
                color: UiConstants.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (product.stock > 0)
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.amber[700],
                  ),
                  const SizedBox(width: 2),
                  Text(
                    product.rating.toStringAsFixed(1),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
          ],
        ),
        if (showAddToCartButton) _buildAddToCartButton(context),
      ],
    );
  }

  Widget _buildAddToCartButton(BuildContext context, {bool compact = false}) {
    return Consumer<CartViewModel>(
      builder: (context, cartViewModel, child) {
        final inCart = cartViewModel.isInCart(product.id);
        final quantity = cartViewModel.getQuantityForProduct(product.id);
        
        if (inCart && !compact) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: UiConstants.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 16),
                  onPressed: () async {
                    if (quantity > 1) {
                      await cartViewModel.updateQuantity(product.id, quantity - 1);
                    } else {
                      await cartViewModel.removeFromCart(product.id);
                    }
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                  ),
                ),
                Text(
                  '$quantity',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 16),
                  onPressed: () async {
                    await cartViewModel.addToCart(
                      product.id,
                      product.name,
                      product.price,
                    );
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                  ),
                ),
              ],
            ),
          );
        }
        
        return IconButton(
          icon: Icon(
            inCart ? Icons.shopping_cart : Icons.add_shopping_cart,
            color: inCart ? UiConstants.primaryColor : null,
          ),
          onPressed: product.isInStock
              ? () async {
                  await cartViewModel.addToCart(
                    product.id,
                    product.name,
                    product.price,
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} agregado al carrito'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              : null,
          tooltip: product.isInStock ? 'Agregar al carrito' : 'Sin stock',
        );
      },
    );
  }
}