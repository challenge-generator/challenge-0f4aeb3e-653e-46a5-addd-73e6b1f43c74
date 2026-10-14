import 'package:flutter/material.dart';

class PerformanceConstants {
  // Umbrales de rendimiento para métricas clave
  static const int cacheDurationInDays = 7;
  static const int maxCacheItems = 100;
  static const double minImageCacheWidth = 300.0;
  static const double minImageCacheHeight = 300.0;
  static const int listViewCacheExtent = 5;
  static const Duration networkTimeout = Duration(seconds: 10);

  // Límites de rendimiento aceptable
  static const Duration maxFrameBuildTime = Duration(milliseconds: 16);
  static const Duration maxNetworkLatency = Duration(milliseconds: 500);
  static const int maxMemoryUsageMB = 200;
  static const double maxCpuUsage = 0.8;

  // Configuración para lazy loading
  static const int initialProductLoadCount = 10;
  static const int productPageSize = 20;

  // Configuración de caché de imágenes
  static const FilterQuality defaultImageFilterQuality = FilterQuality.low;
  static const BoxFit defaultImageBoxFit = BoxFit.cover;

  // Umbrales para alertas de rendimiento
  static const double warningCpuUsage = 0.6;
  static const int warningMemoryUsageMB = 150;
  static const Duration warningFrameBuildTime = Duration(milliseconds: 33);

  // Configuración para monitoreo de rendimiento
  static const bool enablePerformanceMonitoring = true;
  static const Duration performanceSamplingInterval = Duration(seconds: 1);
  static const int maxPerformanceHistorySize = 100;

  // Configuración para manejo de errores
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(milliseconds: 500);

  // Configuración para persistencia local
  static const String cachedProductsKey = 'cached_products';
  static const String lastCacheUpdateKey = 'last_cache_update';
  static const String cartItemsKey = 'cart_items';

  // Configuración para optimización de imágenes
  static const int placeholderImageWidth = 50;
  static const int placeholderImageHeight = 50;
  static const Color placeholderColor = Colors.grey;
  static const double placeholderOpacity = 0.3;
}

class NetworkConstants {
  static const String baseUrl = 'https://api.retailapp.com/v1';
  static const String productsEndpoint = '/products';
  static const String productDetailEndpoint = '/products/';
  static const String addToCartEndpoint = '/cart';
  static const String cartItemsEndpoint = '/cart/items';

  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static const Duration connectionTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}

class UiConstants {
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
  static const double defaultElevation = 4.0;
  static const double defaultIconSize = 24.0;
  static const double defaultFontSize = 14.0;
  static const double titleFontSize = 18.0;
  static const double subtitleFontSize = 16.0;

  static const Color primaryColor = Color(0xFF6200EE);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color errorColor = Color(0xFFB00020);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Colors.white;
  static const Color onPrimaryColor = Colors.white;
  static const Color onSecondaryColor = Colors.black;
  static const Color onBackgroundColor = Colors.black;
  static const Color onSurfaceColor = Colors.black;

  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Curve defaultAnimationCurve = Curves.easeInOut;
}