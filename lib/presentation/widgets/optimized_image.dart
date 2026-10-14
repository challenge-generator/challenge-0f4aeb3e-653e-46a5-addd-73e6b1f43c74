import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/performance_monitor.dart';

class OptimizedImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool enableLazyLoading;
  final bool enableCache;
  final String? cacheKey;

  const OptimizedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.enableLazyLoading = true,
    this.enableCache = true,
    this.cacheKey,
  });

  @override
  State<OptimizedImage> createState() => _OptimizedImageState();
}

class _OptimizedImageState extends State<OptimizedImage> {
  late final Stopwatch _loadStopwatch;
  PerformanceMonitor? _performanceMonitor;

  @override
  void initState() {
    super.initState();
    _loadStopwatch = Stopwatch()..start();
    _initializePerformanceMonitor();
  }

  void _initializePerformanceMonitor() {
    try {
      _performanceMonitor = Provider.of<PerformanceMonitor>(
        context,
        listen: false,
      );
    } catch (_) {
      _performanceMonitor = null;
    }
  }

  @override
  void dispose() {
    _loadStopwatch.stop();
    final loadTime = _loadStopwatch.elapsed;
    if (_performanceMonitor != null && widget.imageUrl.isNotEmpty) {
      _performanceMonitor!.recordImageLoadTime(
        widget.imageUrl,
        loadTime,
      );
    }
    super.dispose();
  }

  Widget _buildPlaceholder(BuildContext context) {
    if (widget.placeholder != null) {
      return widget.placeholder!;
    }
    return Container(
      width: widget.width ?? PerformanceConstants.placeholderImageWidth.toDouble(),
      height: widget.height ?? PerformanceConstants.placeholderImageHeight.toDouble(),
      color: PerformanceConstants.placeholderColor.withValues(
        alpha: PerformanceConstants.placeholderOpacity,
      ),
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, Object error, StackTrace? stackTrace) {
    if (widget.errorWidget != null) {
      return widget.errorWidget!;
    }
    return Container(
      width: widget.width ?? PerformanceConstants.placeholderImageWidth.toDouble(),
      height: widget.height ?? PerformanceConstants.placeholderImageHeight.toDouble(),
      color: UiConstants.errorColor.withValues(alpha: 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_outlined,
            size: UiConstants.defaultIconSize,
            color: UiConstants.errorColor,
          ),
          const SizedBox(height: 8),
          Text(
            'Error al cargar imagen',
            style: TextStyle(
              fontSize: UiConstants.defaultFontSize * 0.8,
              color: UiConstants.errorColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    final imageWidget = CachedNetworkImage(
      imageUrl: widget.imageUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit ?? PerformanceConstants.defaultImageBoxFit,
      filterQuality: PerformanceConstants.defaultImageFilterQuality,
      memCacheWidth: widget.width?.toInt() ??
          PerformanceConstants.minImageCacheWidth.toInt(),
      memCacheHeight: widget.height?.toInt() ??
          PerformanceConstants.minImageCacheHeight.toInt(),
      cacheKey: widget.cacheKey ?? widget.imageUrl,
      fadeInDuration: PerformanceConstants.defaultAnimationDuration,
      fadeOutDuration: PerformanceConstants.defaultAnimationDuration,
      placeholderFadeInDuration: PerformanceConstants.defaultAnimationDuration,
      placeholder: (context, url) => _buildPlaceholder(context),
      errorWidget: (context, url, error) => _buildErrorWidget(context, error, null),
    );

    if (widget.borderRadius != null) {
      return ClipRRect(
        borderRadius: widget.borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enableCache) {
      return _buildDirectImage();
    }

    if (!widget.enableLazyLoading) {
      return _buildImage();
    }

    return _buildLazyImage();
  }

  Widget _buildDirectImage() {
    final directImage = Image.network(
      widget.imageUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit ?? PerformanceConstants.defaultImageBoxFit,
      filterQuality: PerformanceConstants.defaultImageFilterQuality,
      cache: false,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedSwitcher(
          duration: PerformanceConstants.defaultAnimationDuration,
          child: frame != null ? child : _buildPlaceholder(context),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildErrorWidget(context, error, stackTrace);
      },
    );

    if (widget.borderRadius != null) {
      return ClipRRect(
        borderRadius: widget.borderRadius!,
        child: directImage,
      );
    }

    return directImage;
  }

  Widget _buildLazyImage() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildImage();
      },
    );
  }
}

class OptimizedImageGallery extends StatelessWidget {
  final List<String> imageUrls;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const OptimizedImageGallery({
    super.key,
    required this.imageUrls,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: 1.0,
      ),
      itemCount: imageUrls.length,
      cacheExtent: PerformanceConstants.listViewCacheExtent.toDouble(),
      itemBuilder: (context, index) {
        return OptimizedImage(
          imageUrl: imageUrls[index],
          width: width,
          height: height,
          fit: fit,
          borderRadius: borderRadius,
          enableLazyLoading: true,
          enableCache: true,
        );
      },
    );
  }
}