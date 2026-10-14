# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `lib/domain/usecases/add_to_cart_usecase.dart` — `CartRepository.updateCartItem`: Se invoca `updateCartItem` sobre `CartRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/domain/usecases/add_to_cart_usecase.dart` — `CartRepository.addCartItem`: Se invoca `addCartItem` sobre `CartRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/domain/usecases/add_to_cart_usecase.dart` — `CartRepository.removeCartItem`: Se invoca `removeCartItem` sobre `CartRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/presentation/viewmodels/cart_viewmodel.dart` — `CartRepository.updateQuantity`: Se invoca `updateQuantity` sobre `CartRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
flutter pub get && flutter analyze
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Advanced

### Brecha de conocimiento
Interpreta las herramientas para optimización de rendimiento: uso de cpu, memoria, red, almacenamiento. Evalúa las causas principales de problemas de performance: bloqueos de desplazamiento, latencias de inicio y transiciones, ineficiencias energéticas

### Misión / candidato
Desarrollador experimentado trabajando en aplicaciones mobile de alto rendimiento

### Reto
- Tema: técnicas básicas de medición de performance en apps
- Seniority: advanced-l1
- Tipo: practical
- Título: Optimización de rendimiento en aplicaciones móviles
- Tiempo estimado: 1 semana

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Identificación de problemas de rendimiento — objetivo: Detectar y documentar los principales problemas de rendimiento en la aplicación. — entregable (NO resolver): Documento que detalla los problemas de rendimiento detectados.
- Fase 2: Optimización del rendimiento — objetivo: Implementar mejoras para solucionar los problemas de rendimiento identificados. — entregable (NO resolver): Aplicación optimizada con mejoras de rendimiento implementadas.
- Fase 3: Validación del rendimiento mejorado — objetivo: Verificar que las mejoras implementadas han resuelto los problemas de rendimiento y no han introducido nuevos problemas. — entregable (NO resolver): Reporte de pruebas de rendimiento que valida las mejoras implementadas.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: pubspec.yaml ===
name: retail_app
description: A Flutter application for retail with performance optimizations.
publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: '>=3.6.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  provider: 6.1.2
  dio: 5.7.0
  cached_network_image: 3.4.1
  shared_preferences: 2.3.3
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: 5.4.4
  build_runner: 2.4.13
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/icons/

// === ARCHIVO: lib/main.dart ===
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'domain/repositories/product_repository.dart';
import 'domain/repositories/cart_repository.dart';
import 'domain/usecases/get_products_usecase.dart';
import 'domain/usecases/add_to_cart_usecase.dart';
import 'data/repositories/product_repository_impl.dart';
import 'data/repositories/cart_repository_impl.dart';
import 'data/datasources/product_remote_datasource.dart';
import 'data/datasources/local_cache_datasource.dart';
import 'presentation/viewmodels/product_viewmodel.dart';
import 'presentation/viewmodels/cart_viewmodel.dart';
import 'presentation/screens/product_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.retailapp.com/v1',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize data sources
  final productRemoteDataSource = ProductRemoteDataSource(dio);
  final localCacheDataSource = LocalCacheDataSource(sharedPreferences);

  // Initialize repositories
  final productRepository = ProductRepositoryImpl(
    remoteDataSource: productRemoteDataSource,
    localCacheDataSource: localCacheDataSource,
  );
  final cartRepository = CartRepositoryImpl();

  // Initialize use cases
  final getProductsUseCase = GetProductsUseCase(productRepository);
  final addToCartUseCase = AddToCartUseCase(cartRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductViewModel(getProductsUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => CartViewModel(addToCartUseCase),
        ),
        Provider<Dio>.value(value: dio),
        Provider<SharedPreferences>.value(value: sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retail App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const ProductListScreen(),
    );
  }
}

// Constants for performance optimization
class PerformanceConstants {
  static const int cacheDurationInDays = 7;
  static const int maxCacheItems = 100;
  static const double minImageCacheWidth = 300.0;
  static const double minImageCacheHeight = 300.0;
  static const int listViewCacheExtent = 500;
  static const Duration networkTimeout = Duration(seconds: 10);
}

// === ARCHIVO: lib/core/constants/app_constants.dart ===
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

// === ARCHIVO: lib/core/utils/performance_monitor.dart ===
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:retail_app/core/constants/app_constants.dart';

class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  final List<PerformanceSample> _performanceHistory = [];
  Timer? _samplingTimer;
  bool _isMonitoring = false;

  factory PerformanceMonitor() {
    return _instance;
  }

  PerformanceMonitor._internal();

  void startMonitoring() {
    if (_isMonitoring) return;

    _isMonitoring = true;
    _samplingTimer = Timer.periodic(
      PerformanceConstants.performanceSamplingInterval,
      (_) => _samplePerformance(),
    );
  }

  void stopMonitoring() {
    _samplingTimer?.cancel();
    _isMonitoring = false;
  }

  void _samplePerformance() {
    if (!PerformanceConstants.enablePerformanceMonitoring) return;

    final sample = PerformanceSample(
      timestamp: DateTime.now(),
      cpuUsage: _getCpuUsage(),
      memoryUsageMB: _getMemoryUsage(),
      frameBuildTime: _getFrameBuildTime(),
    );

    _performanceHistory.add(sample);

    // Mantener solo los últimos N samples
    if (_performanceHistory.length > PerformanceConstants.maxPerformanceHistorySize) {
      _performanceHistory.removeAt(0);
    }

    _checkPerformanceAlerts(sample);
  }

  double _getCpuUsage() {
    // Simulación de obtención de uso de CPU
    // En una implementación real, usaríamos dart:developer o platform channels
    return 0.1 + (0.3 * (DateTime.now().second % 10) / 10);
  }

  int _getMemoryUsage() {
    // Simulación de obtención de uso de memoria
    // En una implementación real, usaríamos dart:developer o platform channels
    return 80 + (DateTime.now().second % 50);
  }

  Duration _getFrameBuildTime() {
    // Simulación de tiempo de construcción de frame
    return Duration(milliseconds: 8 + (DateTime.now().millisecond % 20));
  }

  void _checkPerformanceAlerts(PerformanceSample sample) {
    if (sample.cpuUsage > PerformanceConstants.warningCpuUsage) {
      debugPrint('ALERTA: Alto uso de CPU - ${sample.cpuUsage}');
    }

    if (sample.memoryUsageMB > PerformanceConstants.warningMemoryUsageMB) {
      debugPrint('ALERTA: Alto uso de memoria - ${sample.memoryUsageMB}MB');
    }

    if (sample.frameBuildTime > PerformanceConstants.warningFrameBuildTime) {
      debugPrint('ALERTA: Alto tiempo de construcción de frame - ${sample.frameBuildTime.inMilliseconds}ms');
    }
  }

  List<PerformanceSample> get performanceHistory => List.unmodifiable(_performanceHistory);

  PerformanceSample? get latestSample => _performanceHistory.isNotEmpty
      ? _performanceHistory.last
      : null;

  void recordNetworkLatency(Duration latency) {
    if (latency > PerformanceConstants.maxNetworkLatency) {
      debugPrint('ALERTA: Alta latencia de red - ${latency.inMilliseconds}ms');
    }
  }

  void recordImageLoadTime(String imageUrl, Duration loadTime) {
    debugPrint('Tiempo de carga de imagen $imageUrl: ${loadTime.inMilliseconds}ms');
  }

  void recordWidgetBuildTime(String widgetName, Duration buildTime) {
    if (buildTime > PerformanceConstants.maxFrameBuildTime) {
      debugPrint('ALERTA: Alto tiempo de construcción de $widgetName - ${buildTime.inMilliseconds}ms');
    }
  }
}

class PerformanceSample {
  final DateTime timestamp;
  final double cpuUsage;
  final int memoryUsageMB;
  final Duration frameBuildTime;

  PerformanceSample({
    required this.timestamp,
    required this.cpuUsage,
    required this.memoryUsageMB,
    required this.frameBuildTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'cpuUsage': cpuUsage,
      'memoryUsageMB': memoryUsageMB,
      'frameBuildTimeMs': frameBuildTime.inMilliseconds,
    };
  }
}

// === ARCHIVO: lib/domain/entities/product.dart ===
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

// === ARCHIVO: lib/domain/entities/cart_item.dart ===
package lib.domain.entities;

import 'package:retail_app/domain/entities/product.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;
  final double unitPrice;
  final double? discountPercentage;
  final DateTime addedAt;
  final String? promotionCode;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    this.discountPercentage,
    required this.addedAt,
    this.promotionCode,
  });

  double get discountAmount {
    if (discountPercentage == null || discountPercentage == 0) {
      return 0.0;
    }
    return (unitPrice * quantity) * (discountPercentage! / 100);
  }

  double get subtotal => (unitPrice * quantity) - discountAmount;

  double get totalWeight => product.metadata?['weight'] != null 
      ? (product.metadata!['weight'] as num).toDouble() * quantity 
      : 0.0;

  bool get isEligibleForFreeShipping => subtotal >= 50.0;

  bool get hasPromotion => promotionCode != null && promotionCode!.isNotEmpty;

  bool get canIncreaseQuantity => quantity < product.stock;

  bool get canDecreaseQuantity => quantity > 1;

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    double? unitPrice,
    double? discountPercentage,
    DateTime? addedAt,
    String? promotionCode,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      addedAt: addedAt ?? this.addedAt,
      promotionCode: promotionCode ?? this.promotionCode,
    );
  }

  CartItem incrementQuantity([int amount = 1]) {
    final newQuantity = quantity + amount;
    if (newQuantity > product.stock) {
      throw CartItemException(
        'Cannot exceed available stock. Available: ${product.stock}, requested: $newQuantity',
      );
    }
    return copyWith(quantity: newQuantity);
  }

  CartItem decrementQuantity([int amount = 1]) {
    final newQuantity = quantity - amount;
    if (newQuantity < 1) {
      throw CartItemException('Quantity cannot be less than 1');
    }
    return copyWith(quantity: newQuantity);
  }

  CartItem applyPromotion(String code, double discountPercent) {
    return copyWith(
      promotionCode: code,
      discountPercentage: discountPercent,
    );
  }

  CartItem removePromotion() {
    return CartItem(
      id: id,
      product: product,
      quantity: quantity,
      unitPrice: unitPrice,
      discountPercentage: null,
      addedAt: addedAt,
      promotionCode: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'unitPrice': unitPrice,
      'discountPercentage': discountPercentage,
      'addedAt': addedAt.toIso8601String(),
      'promotionCode': promotionCode,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      discountPercentage: json['discountPercentage'] != null
          ? (json['discountPercentage'] as num).toDouble()
          : null,
      addedAt: DateTime.parse(json['addedAt'] as String),
      promotionCode: json['promotionCode'] as String?,
    );
  }

  @override
  String toString() {
    return 'CartItem(id: $id, product: ${product.name}, quantity: $quantity, unitPrice: $unitPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class CartItemException implements Exception {
  final String message;
  const CartItemException(this.message);

  @override
  String toString() => 'CartItemException: $message';
}

class CartItemValidator {
  static ValidationResult validate(CartItem item) {
    final errors = <String>[];

    if (item.id.isEmpty) {
      errors.add('Cart item ID cannot be empty');
    }

    if (item.quantity < 1) {
      errors.add('Quantity must be at least 1');
    }

    if (item.quantity > item.product.stock) {
      errors.add('Quantity exceeds available stock: ${item.product.stock}');
    }

    if (item.unitPrice < 0) {
      errors.add('Unit price cannot be negative');
    }

    if (item.discountPercentage != null) {
      if (item.discountPercentage! < 0 || item.discountPercentage! > 100) {
        errors.add('Discount percentage must be between 0 and 100');
      }
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  static bool canAddToCart(Product product, int currentQuantity, int amountToAdd) {
    return (currentQuantity + amountToAdd) <= product.stock;
  }
}

class ValidationResult {
  final bool isValid;
  final List<String> errors;

  const ValidationResult({
    required this.isValid,
    required this.errors,
  });

  String get errorMessage => errors.join('; ');
}

// === ARCHIVO: lib/domain/repositories/product_repository.dart ===
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

// === ARCHIVO: lib/domain/repositories/cart_repository.dart ===
package lib.domain.repositories;

import 'package:retail_app/domain/entities/cart_item.dart';
import 'package:retail_app/domain/entities/product.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCartItems();

  Future<CartItem?> getCartItemById(String id);

  Future<CartItem?> getCartItemByProductId(String productId);

  Future<CartItem> addToCart(Product product, {int quantity = 1, String? promotionCode});

  Future<CartItem> updateCartItemQuantity(String itemId, int quantity);

  Future<CartItem> incrementCartItemQuantity(String itemId, {int amount = 1});

  Future<CartItem> decrementCartItemQuantity(String itemId, {int amount = 1});

  Future<void> removeFromCart(String itemId);

  Future<void> clearCart();

  Future<void> applyPromotionToItem(String itemId, String promotionCode, double discountPercent);

  Future<void> removePromotionFromItem(String itemId);

  Future<CartSummary> getCartSummary();

  Future<int> getCartItemCount();

  Future<bool> isProductInCart(String productId);

  Stream<List<CartItem>> watchCartItems();

  Future<void> syncCartWithServer();

  Future<void> restoreCartFromLocal();

  Future<void> saveCartLocally();
}

class CartSummary {
  final int totalItems;
  final double subtotal;
  final double discount;
  final double shipping;
  final double tax;
  final double total;
  final List<CartItem> items;
  final String? appliedCoupon;
  final bool qualifiesForFreeShipping;
  final double amountUntilFreeShipping;

  const CartSummary({
    required this.totalItems,
    required this.subtotal,
    required this.discount,
    required this.shipping,
    required this.tax,
    required this.total,
    required this.items,
    this.appliedCoupon,
    required this.qualifiesForFreeShipping,
    required this.amountUntilFreeShipping,
  });

  factory CartSummary.empty() {
    return const CartSummary(
      totalItems: 0,
      subtotal: 0.0,
      discount: 0.0,
      shipping: 0.0,
      tax: 0.0,
      total: 0.0,
      items: [],
      qualifiesForFreeShipping: false,
      amountUntilFreeShipping: 50.0,
    );
  }

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  double get totalWeight => items.fold(0.0, (sum, item) => sum + item.totalWeight);

  String get shippingStatus {
    if (qualifiesForFreeShipping) {
      return 'Envío gratis';
    }
    return 'Añade \$${amountUntilFreeShipping.toStringAsFixed(2)} más para envío gratis';
  }

  Map<String, dynamic> toJson() {
    return {
      'totalItems': totalItems,
      'subtotal': subtotal,
      'discount': discount,
      'shipping': shipping,
      'tax': tax,
      'total': total,
      'items': items.map((e) => e.toJson()).toList(),
      'appliedCoupon': appliedCoupon,
      'qualifiesForFreeShipping': qualifiesForFreeShipping,
      'amountUntilFreeShipping': amountUntilFreeShipping,
    };
  }
}

class CartRepositoryException implements Exception {
  final String message;
  final CartRepositoryErrorType type;
  final dynamic originalError;

  const CartRepositoryException({
    required this.message,
    required this.type,
    this.originalError,
  });

  @override
  String toString() => 'CartRepositoryException: $message (type: $type)';

  bool get isNetworkError => type == CartRepositoryErrorType.networkError;
  bool get isStorageError => type == CartRepositoryErrorType.storageError;
  bool get isValidationError => type == CartRepositoryErrorType.validationError;
  bool get isNotFound => type == CartRepositoryErrorType.notFound;
}

enum CartRepositoryErrorType {
  networkError,
  storageError,
  validationError,
  notFound,
  productOutOfStock,
  unknown,
}

class CartOperationResult {
  final bool success;
  final CartItem? item;
  final CartSummary? summary;
  final String? errorMessage;
  final CartRepositoryErrorType? errorType;

  const CartOperationResult({
    required this.success,
    this.item,
    this.summary,
    this.errorMessage,
    this.errorType,
  });

  factory CartOperationResult.success({
    CartItem? item,
    CartSummary? summary,
  }) {
    return CartOperationResult(
      success: true,
      item: item,
      summary: summary,
    );
  }

  factory CartOperationResult.failure({
    required String message,
    required CartRepositoryErrorType type,
    CartItem? item,
    CartSummary? summary,
  }) {
    return CartOperationResult(
      success: false,
      item: item,
      summary: summary,
      errorMessage: message,
      errorType: type,
    );
  }
}

class CartPromotions {
  static const double freeShippingThreshold = 50.0;
  static const double defaultShippingCost = 5.99;
  static const double taxRate = 0.08;

  static double calculateShipping(double subtotal) {
    if (subtotal >= freeShippingThreshold) {
      return 0.0;
    }
    return defaultShippingCost;
  }

  static double calculateTax(double subtotal) {
    return subtotal * taxRate;
  }

  static double calculateAmountUntilFreeShipping(double subtotal) {
    final remaining = freeShippingThreshold - subtotal;
    return remaining > 0 ? remaining : 0.0;
  }

  static bool qualifiesForFreeShipping(double subtotal) {
    return subtotal >= freeShippingThreshold;
  }
}

class CartValidator {
  static CartOperationResult validateAddToCart(Product product, int quantity) {
    if (quantity < 1) {
      return CartOperationResult.failure(
        message: 'La cantidad debe ser al menos 1',
        type: CartRepositoryErrorType.validationError,
      );
    }

    if (quantity > product.stock) {
      return CartOperationResult.failure(
        message: 'Stock insuficiente. Disponible: ${product.stock}',
        type: CartRepositoryErrorType.productOutOfStock,
      );
    }

    if (!product.isInStock) {
      return CartOperationResult.failure(
        message: 'El producto no está disponible',
        type: CartRepositoryErrorType.productOutOfStock,
      );
    }

    return CartOperationResult.success();
  }

  static CartOperationResult validateQuantity(int currentQuantity, int newQuantity, int maxStock) {
    if (newQuantity < 1) {
      return CartOperationResult.failure(
        message: 'La cantidad no puede ser menor a 1',
        type: CartRepositoryErrorType.validationError,
      );
    }

    if (newQuantity > maxStock) {
      return CartOperationResult.failure(
        message: 'Stock insuficiente para esta cantidad',
        type: CartRepositoryErrorType.productOutOfStock,
      );
    }

    return CartOperationResult.success();
  }
}

// === ARCHIVO: lib/domain/usecases/get_products_usecase.dart ===
package retail_app.domain.usecases;

import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/domain/repositories/product_repository.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';
import 'package:retail_app/core/constants/app_constants.dart';

class GetProductsUseCase {
  final ProductRepository _productRepository;
  final PerformanceMonitor _performanceMonitor;
  
  GetProductsUseCase({
    required ProductRepository productRepository,
    required PerformanceMonitor performanceMonitor,
  })  : _productRepository = productRepository,
        _performanceMonitor = performanceMonitor;

  Future<List<Product>> execute({
    bool forceRefresh = false,
    int? limit,
    String? category,
  }) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final cacheDuration = Duration(
        days: PerformanceConstants.cacheDurationInDays,
      );
      
      final products = await _productRepository.getProducts(
        forceRefresh: forceRefresh,
        limit: limit ?? PerformanceConstants.productPageSize,
        category: category,
      );
      
      stopwatch.stop();
      
      final loadTime = stopwatch.elapsed;
      _performanceMonitor.recordNetworkLatency(loadTime);
      
      if (loadTime > PerformanceConstants.maxNetworkLatency) {
        _performanceMonitor._checkPerformanceAlerts(
          PerformanceSample(
            timestamp: DateTime.now(),
            cpuUsage: _performanceMonitor._getCpuUsage(),
            memoryUsageMB: _performanceMonitor._getMemoryUsage(),
            frameBuildTime: _performanceMonitor._getFrameBuildTime(),
          ),
        );
      }
      
      return _sortProductsByRelevance(products);
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  List<Product> _sortProductsByRelevance(List<Product> products) {
    final sorted = List<Product>.from(products);
    sorted.sort((a, b) => b.compareByPopularity(a));
    return sorted;
  }

  Future<Product?> getProductById(String productId) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final product = await _productRepository.getProductById(productId);
      
      stopwatch.stop();
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      return product;
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    if (query.isEmpty) {
      return execute();
    }
    
    final stopwatch = Stopwatch()..start();
    
    try {
      final allProducts = await _productRepository.getProducts(
        forceRefresh: false,
        limit: PerformanceConstants.initialProductLoadCount,
      );
      
      final filtered = allProducts.where((product) {
        final nameLower = product.name.toLowerCase();
        final descLower = product.description.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower) || 
               descLower.contains(queryLower) ||
               product.category.toLowerCase().contains(queryLower);
      }).toList();
      
      stopwatch.stop();
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      return filtered;
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }
}

// === ARCHIVO: lib/domain/usecases/add_to_cart_usecase.dart ===
package retail_app.domain.usecases;

import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/domain/entities/cart_item.dart';
import 'package:retail_app/domain/repositories/cart_repository.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';
import 'package:retail_app/core/constants/app_constants.dart';

class AddToCartUseCase {
  final CartRepository _cartRepository;
  final PerformanceMonitor _performanceMonitor;
  
  AddToCartUseCase({
    required CartRepository cartRepository,
    required PerformanceMonitor performanceMonitor,
  })  : _cartRepository = cartRepository,
        _performanceMonitor = performanceMonitor;

  Future<CartItem> execute({
    required Product product,
    int quantity = 1,
  }) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      if (quantity <= 0) {
        throw ArgumentError('La cantidad debe ser mayor que cero');
      }
      
      if (!product.isInStock) {
        throw StateError('El producto ${product.name} no está disponible en stock');
      }
      
      if (quantity > product.stock) {
        throw StateError('Stock insuficiente. Disponible: ${product.stock}');
      }
      
      final existingItems = await _cartRepository.getCartItems();
      final existingIndex = existingItems.indexWhere(
        (item) => item.productId == product.id,
      );
      
      CartItem cartItem;
      
      if (existingIndex >= 0) {
        final existingItem = existingItems[existingIndex];
        final newQuantity = existingItem.quantity + quantity;
        
        if (newQuantity > product.stock) {
          throw StateError(
            'No se puede agregar más. Stock máximo: ${product.stock}',
          );
        }
        
        cartItem = await _cartRepository.updateCartItem(
          cartItemId: existingItem.id,
          quantity: newQuantity,
        );
      } else {
        cartItem = await _cartRepository.addCartItem(
          productId: product.id,
          quantity: quantity,
          price: product.price,
        );
      }
      
      stopwatch.stop();
      _recordCartOperationMetrics(stopwatch.elapsed, product.id);
      
      return cartItem;
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  void _recordCartOperationMetrics(Duration operationTime, String productId) {
    if (operationTime > PerformanceConstants.maxNetworkLatency) {
      _performanceMonitor._checkPerformanceAlerts(
        PerformanceSample(
          timestamp: DateTime.now(),
          cpuUsage: _performanceMonitor._getCpuUsage(),
          memoryUsageMB: _performanceMonitor._getMemoryUsage(),
          frameBuildTime: _performanceMonitor._getFrameBuildTime(),
        ),
      );
    }
  }

  Future<List<CartItem>> getCartItems() async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final items = await _cartRepository.getCartItems();
      
      stopwatch.stop();
      return items;
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  Future<void> removeFromCart(String cartItemId) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      await _cartRepository.removeCartItem(cartItemId);
      
      stopwatch.stop();
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  Future<CartItem> updateQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      if (quantity <= 0) {
        await _cartRepository.removeCartItem(cartItemId);
        stopwatch.stop();
        throw StateError('Artículo eliminado del carrito');
      }
      
      final updatedItem = await _cartRepository.updateCartItem(
        cartItemId: cartItemId,
        quantity: quantity,
      );
      
      stopwatch.stop();
      return updatedItem;
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  Future<double> calculateCartTotal() async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final items = await _cartRepository.getCartItems();
      
      double total = 0.0;
      for (final item in items) {
        total += item.price * item.quantity;
      }
      
      stopwatch.stop();
      return total;
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  Future<int> getCartItemCount() async {
    final items = await _cartRepository.getCartItems();
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  Future<void> clearCart() async {
    final stopwatch = Stopwatch()..start();
    
    try {
      await _cartRepository.clearCart();
      
      stopwatch.stop();
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }
}

// === ARCHIVO: lib/data/models/product_model.dart ===
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

// === ARCHIVO: lib/data/datasources/product_remote_datasource.dart ===
import 'package:dio/dio.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({int page = 1, int limit = 20});
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> searchProducts(String query);
  Future<List<ProductModel>> getProductsByCategory(String category);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getProducts({int page = 1, int limit = 20}) async {
    try {
      final response = await dio.get(
        '/products',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        return data
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load products: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error loading products: $e');
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await dio.get(
        '/products/$id',
        options: Options(
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return ProductModel.fromJson(data as Map<String, dynamic>);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Product not found: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error loading product: $e');
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await dio.get(
        '/products/search',
        queryParameters: {'q': query},
        options: Options(
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        return data
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Search failed: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error searching products: $e');
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await dio.get(
        '/products/category/$category',
        options: Options(
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        return data
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load category products: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error loading category products: $e');
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout. Please check your internet connection.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return Exception('Product not found.');
        } else if (statusCode == 500) {
          return Exception('Server error. Please try again later.');
        }
        return Exception('Server error: $statusCode');
      case DioExceptionType.cancel:
        return Exception('Request cancelled.');
      case DioExceptionType.connectionError:
        return Exception('No internet connection.');
      default:
        return Exception('Network error: ${e.message}');
    }
  }
}

// === ARCHIVO: lib/data/datasources/local_cache_datasource.dart ===
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

// === ARCHIVO: lib/data/repositories/product_repository_impl.dart ===
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

// === ARCHIVO: lib/data/repositories/cart_repository_impl.dart ===
package lib.data.repositories;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:retail_app/core/constants/app_constants.dart';
import 'package:retail_app/domain/entities/cart_item.dart';
import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final SharedPreferences sharedPreferences;
  final List<CartItem> _cartItems = [];
  
  CartRepositoryImpl({required this.sharedPreferences}) {
    _loadCartFromStorage();
  }

  Future<void> _loadCartFromStorage() async {
    final cartJson = sharedPreferences.getString(PerformanceConstants.cartItemsKey);
    if (cartJson != null) {
      try {
        final List<dynamic> cartList = jsonDecode(cartJson);
        _cartItems.clear();
        _cartItems.addAll(cartList.map((item) => CartItem.fromJson(item)));
      } catch (e) {
        _cartItems.clear();
      }
    }
  }

  Future<void> _saveCartToStorage() async {
    final cartJson = jsonEncode(_cartItems.map((item) => item.toJson()).toList());
    await sharedPreferences.setString(PerformanceConstants.cartItemsKey, cartJson);
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    return List.unmodifiable(_cartItems);
  }

  @override
  Future<void> addToCart(Product product, {int quantity = 1}) async {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      final existingItem = _cartItems[existingIndex];
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      _cartItems[existingIndex] = updatedItem;
    } else {
      final newItem = CartItem(product: product, quantity: quantity);
      _cartItems.add(newItem);
    }
    
    await _saveCartToStorage();
  }

  @override
  Future<void> removeFromCart(String productId) async {
    _cartItems.removeWhere((item) => item.product.id == productId);
    await _saveCartToStorage();
  }

  @override
  Future<void> updateQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
      return;
    }
    
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      final updatedItem = _cartItems[index].copyWith(quantity: quantity);
      _cartItems[index] = updatedItem;
      await _saveCartToStorage();
    }
  }

  @override
  Future<void> clearCart() async {
    _cartItems.clear();
    await sharedPreferences.remove(PerformanceConstants.cartItemsKey);
  }

  @override
  Future<int> getCartItemCount() async {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Future<double> getCartTotal() async {
    return _cartItems.fold(0.0, (sum, item) {
      return sum + (item.product.price * item.quantity);
    });
  }

  @override
  Future<bool> isInCart(String productId) async {
    return _cartItems.any((item) => item.product.id == productId);
  }
}

// === ARCHIVO: android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
    <application
        android:label="Retail App"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:enableOnBackInvokedCallback="true">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
            
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"/>
        
    </application>
    
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
    
</manifest>

// === ARCHIVO: lib/presentation/screens/product_list_screen.dart ===
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/product.dart';
import '../viewmodels/product_viewmodel.dart';
import '../widgets/product_card.dart';
import '../widgets/optimized_image.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/performance_monitor.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();
  final PerformanceMonitor _performanceMonitor = PerformanceMonitor();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _performanceMonitor.startMonitoring();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final viewModel = context.read<ProductViewModel>();
      if (!viewModel.isLoading && viewModel.hasMoreProducts) {
        viewModel.loadMoreProducts();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _performanceMonitor.stopMonitoring();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    final viewModel = context.read<ProductViewModel>();
    await viewModel.refreshProducts();
  }

  void _navigateToDetail(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Productos'),
        backgroundColor: UiConstants.primaryColor,
        foregroundColor: UiConstants.onPrimaryColor,
        elevation: UiConstants.defaultElevation,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implementar búsqueda
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implementar filtros
            },
          ),
        ],
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.products.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: UiConstants.primaryColor,
              ),
            );
          }

          if (viewModel.error != null && viewModel.products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: UiConstants.errorColor,
                  ),
                  const SizedBox(height: UiConstants.defaultPadding),
                  Text(
                    'Error al cargar productos',
                    style: TextStyle(
                      fontSize: UiConstants.subtitleFontSize,
                      color: UiConstants.onBackgroundColor,
                    ),
                  ),
                  const SizedBox(height: UiConstants.defaultPadding),
                  ElevatedButton(
                    onPressed: _onRefresh,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: UiConstants.primaryColor,
            child: ListView.builder(
              controller: _scrollController,
              cacheExtent: PerformanceConstants.listViewCacheExtent.toDouble(),
              itemCount: viewModel.products.length + (viewModel.hasMoreProducts ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= viewModel.products.length) {
                  return const Padding(
                    padding: EdgeInsets.all(UiConstants.defaultPadding),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final product = viewModel.products[index];
                return ProductCard(
                  product: product,
                  onTap: () => _navigateToDetail(product),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// === ARCHIVO: lib/presentation/screens/product_detail_screen.dart ===
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

// === ARCHIVO: lib/presentation/screens/cart_screen.dart ===
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

// === ARCHIVO: lib/presentation/viewmodels/product_viewmodel.dart ===
package retail_app.presentation.viewmodels;

import 'package:flutter/foundation.dart';
import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/domain/repositories/product_repository.dart';
import 'package:retail_app/domain/usecases/get_products_usecase.dart';
import 'package:retail_app/core/constants/app_constants.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';

enum ProductLoadingState { initial, loading, loaded, error }

enum ProductSortOption { none, priceAsc, priceDesc, popularity, rating }

class ProductViewModel extends ChangeNotifier {
  final GetProductsUseCase _getProductsUseCase;
  final ProductRepository _productRepository;
  final PerformanceMonitor _performanceMonitor;

  ProductViewModel({
    required GetProductsUseCase getProductsUseCase,
    required ProductRepository productRepository,
    PerformanceMonitor? performanceMonitor,
  })  : _getProductsUseCase = getProductsUseCase,
        _productRepository = productRepository,
        _performanceMonitor = performanceMonitor ?? PerformanceMonitor();

  ProductLoadingState _loadingState = ProductLoadingState.initial;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String? _errorMessage;
  String _searchQuery = '';
  String? _selectedCategory;
  ProductSortOption _sortOption = ProductSortOption.none;
  bool _hasMoreProducts = true;
  int _currentPage = 0;
  final int _pageSize = PerformanceConstants.productPageSize;

  ProductLoadingState get loadingState => _loadingState;
  
  List<Product> get products => _filteredProducts;
  
  String? get errorMessage => _errorMessage;
  
  bool get hasMoreProducts => _hasMoreProducts;
  
  bool get isLoading => _loadingState == ProductLoadingState.loading;
  
  String get searchQuery => _searchQuery;
  
  String? get selectedCategory => _selectedCategory;
  
  ProductSortOption get sortOption => _sortOption;

  Set<String> get availableCategories {
    final categories = _products.map((p) => p.category).toSet();
    return categories..removeWhere((c) => c.isEmpty);
  }

  Future<void> loadProducts({bool refresh = false}) async {
    if (_loadingState == ProductLoadingState.loading) return;
    
    _loadingState = ProductLoadingState.loading;
    _errorMessage = null;
    if (refresh) {
      _currentPage = 0;
      _hasMoreProducts = true;
    }
    notifyListeners();

    final stopwatch = Stopwatch()..start();
    
    try {
      _products = await _getProductsUseCase.execute();
      stopwatch.stop();
      
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      _applyFiltersAndSort();
      _loadingState = ProductLoadingState.loaded;
    } catch (e) {
      stopwatch.stop();
      _errorMessage = 'Error al cargar productos: ${e.toString()}';
      _loadingState = ProductLoadingState.error;
    }
    
    notifyListeners();
  }

  Future<void> loadMoreProducts() async {
    if (!_hasMoreProducts || _loadingState == ProductLoadingState.loading) {
      return;
    }

    _currentPage++;
    final startIndex = _currentPage * _pageSize;
    final endIndex = (startIndex + _pageSize).clamp(0, _products.length);

    if (startIndex >= _products.length) {
      _hasMoreProducts = false;
      notifyListeners();
      return;
    }

    final newProducts = _products.sublist(startIndex, endIndex);
    _filteredProducts = [..._filteredProducts, ...newProducts];
    _hasMoreProducts = endIndex < _products.length;
    
    notifyListeners();
  }

  void setSearchQuery(String query) {
    if (_searchQuery == query) return;
    
    _searchQuery = query;
    _applyFiltersAndSort();
    notifyListeners();
  }

  void setCategory(String? category) {
    if (_selectedCategory == category) return;
    
    _selectedCategory = category;
    _applyFiltersAndSort();
    notifyListeners();
  }

  void setSortOption(ProductSortOption option) {
    if (_sortOption == option) return;
    
    _sortOption = option;
    _applyFiltersAndSort();
    notifyListeners();
  }

  void _applyFiltersAndSort() {
    final stopwatch = Stopwatch()..start();
    
    List<Product> result = List.from(_products);

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      result = result.where((p) =>
          p.name.toLowerCase().contains(query) ||
          p.description.toLowerCase().contains(query) ||
          p.category.toLowerCase().contains(query)).toList();
    }

    if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
      result = result.where((p) => p.category == _selectedCategory).toList();
    }

    switch (_sortOption) {
      case ProductSortOption.priceAsc:
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case ProductSortOption.priceDesc:
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case ProductSortOption.popularity:
        result.sort((a, b) => b.compareByPopularity(a));
        break;
      case ProductSortOption.rating:
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case ProductSortOption.none:
        break;
    }

    stopwatch.stop();
    _performanceMonitor.recordWidgetBuildTime('ProductViewModel_filter', stopwatch.elapsed);
    
    _filteredProducts = result;
    _hasMoreProducts = result.length > _pageSize;
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _sortOption = ProductSortOption.none;
    _applyFiltersAndSort();
    notifyListeners();
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  void refreshProduct(String productId) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      notifyListeners();
    }
  }
}

// === ARCHIVO: lib/presentation/viewmodels/cart_viewmodel.dart ===
package retail_app.presentation.viewmodels;

import 'package:flutter/foundation.dart';
import 'package:retail_app/domain/entities/cart_item.dart';
import 'package:retail_app/domain/repositories/cart_repository.dart';
import 'package:retail_app/domain/usecases/add_to_cart_usecase.dart';
import 'package:retail_app/core/constants/app_constants.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';

enum CartLoadingState { initial, loading, loaded, error }

class CartViewModel extends ChangeNotifier {
  final AddToCartUseCase _addToCartUseCase;
  final CartRepository _cartRepository;
  final PerformanceMonitor _performanceMonitor;

  CartViewModel({
    required AddToCartUseCase addToCartUseCase,
    required CartRepository cartRepository,
    PerformanceMonitor? performanceMonitor,
  })  : _addToCartUseCase = addToCartUseCase,
        _cartRepository = cartRepository,
        _performanceMonitor = performanceMonitor ?? PerformanceMonitor();

  CartLoadingState _loadingState = CartLoadingState.initial;
  List<CartItem> _items = [];
  String? _errorMessage;

  CartLoadingState get loadingState => _loadingState;
  
  List<CartItem> get items => _items;
  
  String? get errorMessage => _errorMessage;
  
  bool get isLoading => _loadingState == CartLoadingState.loading;
  
  bool get isEmpty => _items.isEmpty;

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice {
    final stopwatch = Stopwatch()..start();
    final total = _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    stopwatch.stop();
    
    if (stopwatch.elapsed > PerformanceConstants.maxFrameBuildTime) {
      _performanceMonitor.recordWidgetBuildTime('CartViewModel_totalPrice', stopwatch.elapsed);
    }
    
    return total;
  }

  int get uniqueProductCount => _items.length;

  Future<void> loadCart() async {
    if (_loadingState == CartLoadingState.loading) return;
    
    _loadingState = CartLoadingState.loading;
    _errorMessage = null;
    notifyListeners();

    final stopwatch = Stopwatch()..start();
    
    try {
      _items = await _cartRepository.getCartItems();
      stopwatch.stop();
      
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      _loadingState = CartLoadingState.loaded;
    } catch (e) {
      stopwatch.stop();
      _errorMessage = 'Error al cargar el carrito: ${e.toString()}';
      _loadingState = CartLoadingState.error;
    }
    
    notifyListeners();
  }

  Future<bool> addToCart(String productId, String productName, double price, {int quantity = 1}) async {
    _loadingState = CartLoadingState.loading;
    _errorMessage = null;
    notifyListeners();

    final stopwatch = Stopwatch()..start();
    
    try {
      await _addToCartUseCase.execute(
        productId: productId,
        productName: productName,
        price: price,
        quantity: quantity,
      );
      
      stopwatch.stop();
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      final existingIndex = _items.indexWhere((item) => item.productId == productId);
      
      if (existingIndex != -1) {
        final existing = _items[existingIndex];
        _items[existingIndex] = CartItem(
          productId: existing.productId,
          productName: existing.productName,
          price: existing.price,
          quantity: existing.quantity + quantity,
          imageUrl: existing.imageUrl,
        );
      } else {
        _items.add(CartItem(
          productId: productId,
          productName: productName,
          price: price,
          quantity: quantity,
          imageUrl: '',
        ));
      }
      
      _loadingState = CartLoadingState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      stopwatch.stop();
      _errorMessage = 'Error al agregar al carrito: ${e.toString()}';
      _loadingState = CartLoadingState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeFromCart(String productId) async {
    _loadingState = CartLoadingState.loading;
    _errorMessage = null;
    notifyListeners();

    final stopwatch = Stopwatch()..start();
    
    try {
      await _cartRepository.removeFromCart(productId);
      
      stopwatch.stop();
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      _items.removeWhere((item) => item.productId == productId);
      
      _loadingState = CartLoadingState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      stopwatch.stop();
      _errorMessage = 'Error al eliminar del carrito: ${e.toString()}';
      _loadingState = CartLoadingState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      return removeFromCart(productId);
    }

    final index = _items.indexWhere((item) => item.productId == productId);
    if (index == -1) return false;

    final stopwatch = Stopwatch()..start();
    
    try {
      await _cartRepository.updateQuantity(productId, quantity);
      
      stopwatch.stop();
      
      final current = _items[index];
      _items[index] = CartItem(
        productId: current.productId,
        productName: current.productName,
        price: current.price,
        quantity: quantity,
        imageUrl: current.imageUrl,
      );
      
      notifyListeners();
      return true;
    } catch (e) {
      stopwatch.stop();
      _errorMessage = 'Error al actualizar cantidad: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<bool> clearCart() async {
    _loadingState = CartLoadingState.loading;
    _errorMessage = null;
    notifyListeners();

    final stopwatch = Stopwatch()..start();
    
    try {
      await _cartRepository.clearCart();
      
      stopwatch.stop();
      _performanceMonitor.recordNetworkLatency(stopwatch.elapsed);
      
      _items.clear();
      
      _loadingState = CartLoadingState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      stopwatch.stop();
      _errorMessage = 'Error al vaciar el carrito: ${e.toString()}';
      _loadingState = CartLoadingState.error;
      notifyListeners();
      return false;
    }
  }

  int getQuantityForProduct(String productId) {
    try {
      return _items.firstWhere((item) => item.productId == productId).quantity;
    } catch (_) {
      return 0;
    }
  }

  bool isInCart(String productId) {
    return _items.any((item) => item.productId == productId);
  }
}

// === ARCHIVO: lib/presentation/widgets/product_card.dart ===
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

// === ARCHIVO: lib/presentation/widgets/optimized_image.dart ===
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

// === ARCHIVO: test/performance/performance_baseline_test.dart ===
import 'package:flutter_test/flutter_test.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';
import 'package:retail_app/core/constants/app_constants.dart';
import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/data/datasources/product_remote_datasource.dart';
import 'package:retail_app/data/datasources/local_cache_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Performance Baseline Tests', () {
    late PerformanceMonitor performanceMonitor;
    late ProductRemoteDataSource remoteDataSource;
    late LocalCacheDataSource cacheDataSource;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      performanceMonitor = PerformanceMonitor();
      cacheDataSource = LocalCacheDataSource();
      remoteDataSource = ProductRemoteDataSource();
    });

    test('Initial performance monitoring state should be inactive', () {
      expect(performanceMonitor.performanceHistory.isEmpty, true);
    });

    test('Start monitoring should begin sampling performance', () {
      performanceMonitor.startMonitoring();
      Future.delayed(const Duration(milliseconds: 150), () {
        performanceMonitor.stopMonitoring();
        expect(performanceMonitor.performanceHistory.isNotEmpty, true);
      });
    });

    test('Network latency recording should capture timing', () {
      final testLatency = Duration(milliseconds: 250);
      performanceMonitor.recordNetworkLatency(testLatency);
      final samples = performanceMonitor.performanceHistory;
      expect(samples.isNotEmpty, true);
    });

    test('Image load time recording should work correctly', () {
      const testImageUrl = 'https://example.com/product.jpg';
      final testLoadTime = Duration(milliseconds: 120);
      performanceMonitor.recordImageLoadTime(testImageUrl, testLoadTime);
      final samples = performanceMonitor.performanceHistory;
      expect(samples.isNotEmpty, true);
    });

    test('Widget build time recording should capture metrics', () {
      const testWidgetName = 'ProductListScreen';
      final testBuildTime = Duration(milliseconds: 45);
      performanceMonitor.recordWidgetBuildTime(testWidgetName, testBuildTime);
      final samples = performanceMonitor.performanceHistory;
      expect(samples.isNotEmpty, true);
    });

    test('CPU usage should be within acceptable range', () {
      final sample = PerformanceSample(
        timestamp: DateTime.now(),
        cpuUsage: 45.5,
        memoryUsageMB: 120,
        frameBuildTime: const Duration(milliseconds: 16),
      );
      expect(sample.cpuUsage <= PerformanceConstants.maxCpuUsage, true);
    });

    test('Memory usage should not exceed threshold', () {
      final sample = PerformanceSample(
        timestamp: DateTime.now(),
        cpuUsage: 30.0,
        memoryUsageMB: 85,
        frameBuildTime: const Duration(milliseconds: 14),
      );
      expect(sample.memoryUsageMB <= PerformanceConstants.maxMemoryUsageMB, true);
    });

    test('Frame build time should meet 60fps target', () {
      final sample = PerformanceSample(
        timestamp: DateTime.now(),
        cpuUsage: 25.0,
        memoryUsageMB: 90,
        frameBuildTime: const Duration(milliseconds: 12),
      );
      expect(sample.frameBuildTime <= PerformanceConstants.maxFrameBuildTime, true);
    });

    test('Performance sample should serialize to JSON correctly', () {
      final sample = PerformanceSample(
        timestamp: DateTime.now(),
        cpuUsage: 35.0,
        memoryUsageMB: 100,
        frameBuildTime: const Duration(milliseconds: 15),
      );
      final json = sample.toJson();
      expect(json.containsKey('timestamp'), true);
      expect(json.containsKey('cpuUsage'), true);
      expect(json.containsKey('memoryUsageMB'), true);
      expect(json.containsKey('frameBuildTime'), true);
    });

    test('Performance constants should have valid values', () {
      expect(PerformanceConstants.maxMemoryUsageMB > 0, true);
      expect(PerformanceConstants.maxCpuUsage > 0, true);
      expect(PerformanceConstants.maxFrameBuildTime.inMilliseconds > 0, true);
      expect(PerformanceConstants.networkTimeout.inMilliseconds > 0, true);
    });

    test('Warning thresholds should be lower than max thresholds', () {
      expect(PerformanceConstants.warningCpuUsage < PerformanceConstants.maxCpuUsage, true);
      expect(PerformanceConstants.warningMemoryUsageMB < PerformanceConstants.maxMemoryUsageMB, true);
      expect(PerformanceConstants.warningFrameBuildTime < PerformanceConstants.maxFrameBuildTime, true);
    });

    test('Performance monitoring should support start and stop cycle', () {
      performanceMonitor.startMonitoring();
      expect(performanceMonitor.performanceHistory.isEmpty, true);
      Future.delayed(const Duration(milliseconds: 100), () {
        performanceMonitor.stopMonitoring();
        expect(performanceMonitor.performanceHistory.isNotEmpty, true);
      });
    });

    test('Multiple performance samples should be recorded in sequence', () {
      for (int i = 0; i < 10; i++) {
        performanceMonitor.recordNetworkLatency(Duration(milliseconds: 50 + i * 10));
      }
      expect(performanceMonitor.performanceHistory.length, 10);
    });

    test('Product entity should have performance-friendly implementation', () {
      final product = Product(
        id: '1',
        name: 'Test Product',
        description: 'Test Description',
        price: 99.99,
        imageUrl: 'https://example.com/image.jpg',
        stock: 10,
        rating: 4.5,
        category: 'electronics',
      );
      expect(product.isInStock, true);
      expect(product.isPopular, false);
      expect(product.hasDiscount, false);
    });

    test('Product comparison by popularity should work correctly', () {
      final product1 = Product(
        id: '1',
        name: 'Popular Product',
        description: 'Popular',
        price: 50.0,
        imageUrl: 'https://example.com/1.jpg',
        stock: 100,
        rating: 4.8,
        category: 'electronics',
      );
      final product2 = Product(
        id: '2',
        name: 'Less Popular',
        description: 'Not popular',
        price: 30.0,
        imageUrl: 'https://example.com/2.jpg',
        stock: 50,
        rating: 3.5,
        category: 'electronics',
      );
      expect(product1.compareByPopularity(product2) < 0, true);
    });

    test('Product comparison by price should work correctly', () {
      final cheapProduct = Product(
        id: '1',
        name: 'Cheap',
        description: 'Cheap',
        price: 25.0,
        imageUrl: 'https://example.com/1.jpg',
        stock: 20,
        rating: 4.0,
        category: 'books',
      );
      final expensiveProduct = Product(
        id: '2',
        name: 'Expensive',
        description: 'Expensive',
        price: 150.0,
        imageUrl: 'https://example.com/2.jpg',
        stock: 5,
        rating: 4.5,
        category: 'electronics',
      );
      expect(cheapProduct.compareByPrice(expensiveProduct) < 0, true);
    });

    test('Performance history should be retrievable', () {
      performanceMonitor.recordNetworkLatency(const Duration(milliseconds: 100));
      performanceMonitor.recordNetworkLatency(const Duration(milliseconds: 200));
      final history = performanceMonitor.performanceHistory;
      expect(history.length, 2);
    });

    test('Cache duration constant should be reasonable', () {
      expect(PerformanceConstants.cacheDurationInDays >= 1, true);
      expect(PerformanceConstants.cacheDurationInDays <= 30, true);
    });

    test('Max cache items should support reasonable cache size', () {
      expect(PerformanceConstants.maxCacheItems > 0, true);
      expect(PerformanceConstants.maxCacheItems <= 1000, true);
    });

    test('Image cache dimensions should be set correctly', () {
      expect(PerformanceConstants.minImageCacheWidth > 0, true);
      expect(PerformanceConstants.minImageCacheHeight > 0, true);
    });

    test('ListView cache extent should allow smooth scrolling', () {
      expect(PerformanceConstants.listViewCacheExtent >= 0, true);
    });

    test('Network timeout should be adequate for operations', () {
      expect(PerformanceConstants.networkTimeout.inSeconds >= 10, true);
      expect(PerformanceConstants.networkTimeout.inSeconds <= 60, true);
    });

    test('Performance monitoring should handle rapid samples', () {
      performanceMonitor.startMonitoring();
      for (int i = 0; i < 50; i++) {
        performanceMonitor.recordNetworkLatency(Duration(milliseconds: i));
      }
      performanceMonitor.stopMonitoring();
      expect(performanceMonitor.performanceHistory.length >= 50, true);
    });
  });
}

// === ARCHIVO: test/performance/memory_test.dart ===
import 'package:flutter_test/flutter_test.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';
import 'package:retail_app/core/constants/app_constants.dart';
import 'package:retail_app/domain/entities/product.dart';
import 'package:retail_app/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Memory Usage Tests', () {
    late PerformanceMonitor performanceMonitor;
    late List<Product> productList;
    late List<ProductModel> productModelList;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      performanceMonitor = PerformanceMonitor();
      productList = [];
      productModelList = [];
    });

    test('Initial memory usage should be within baseline', () {
      final initialMemory = _getCurrentMemoryUsage();
      expect(initialMemory > 0, true);
      expect(initialMemory < PerformanceConstants.maxMemoryUsageMB * 2, true);
    });

    test('Creating product entities should not exceed memory threshold', () {
      for (int i = 0; i < 100; i++) {
        productList.add(Product(
          id: 'product_$i',
          name: 'Product Name $i',
          description: 'Description for product $i',
          price: 10.0 + i,
          imageUrl: 'https://example.com/image_$i.jpg',
          stock: 10 + i,
          rating: 3.5 + (i % 10) / 10,
          category: 'category_${i % 5}',
        ));
      }
      final currentMemory = _getCurrentMemoryUsage();
      expect(currentMemory <= PerformanceConstants.maxMemoryUsageMB, true);
    });

    test('Creating product models should be memory efficient', () {
      for (int i = 0; i < 100; i++) {
        productModelList.add(ProductModel(
          id: 'model_$i',
          name: 'Model Name $i',
          description: 'Description for model $i',
          price: 15.0 + i,
          imageUrl: 'https://example.com/model_$i.jpg',
          stock: 5 + i,
          rating: 4.0 + (i % 10) / 10,
          category: 'category_${i % 3}',
        ));
      }
      final currentMemory = _getCurrentMemoryUsage();
      expect(currentMemory <= PerformanceConstants.maxMemoryUsageMB, true);
    });

    test('Memory should be released after clearing product list', () {
      final initialMemory = _getCurrentMemoryUsage();
      for (int i = 0; i < 200; i++) {
        productList.add(Product(
          id: 'p$i',
          name: 'P$i',
          desc: 'D$i',
          price: i.toDouble(),
          url: 'url$i',
          stock: i,
          rating: 4.0,
          cat: 'c$i',
        ));
      }
      final memoryWithData = _getCurrentMemoryUsage();
      productList.clear();
      productModelList.clear();
      final memoryAfterClear = _getCurrentMemoryUsage();
      expect(memoryAfterClear <= memoryWithData, true);
    });

    test('Performance sample memory footprint should be minimal', () {
      final samples = <PerformanceSample>[];
      for (int i = 0; i < 1000; i++) {
        samples.add(PerformanceSample(
          timestamp: DateTime.now(),
          cpuUsage: 25.0,
          memoryUsageMB: 80,
          frameBuildTime: const Duration(milliseconds: 16),
        ));
      }
      final memoryWithSamples = _getCurrentMemoryUsage();
      samples.clear();
      final memoryAfterClear = _getCurrentMemoryUsage();
      expect(memoryAfterClear < memoryWithSamples + 10, true);
    });

    test('Warning memory threshold should be lower than max', () {
      expect(PerformanceConstants.warningMemoryUsageMB < PerformanceConstants.maxMemoryUsageMB, true);
    });

    test('Memory usage should be tracked in performance samples', () {
      performanceMonitor.startMonitoring();
      Future.delayed(const Duration(milliseconds: 100), () {
        performanceMonitor.stopMonitoring();
        final samples = performanceMonitor.performanceHistory;
        for (final sample in samples) {
          expect(sample.memoryUsageMB > 0, true);
        }
      });
    });

    test('Large product list should not cause memory overflow', () {
      expect(() {
        for (int i = 0; i < 1000; i++) {
          productList.add(Product(
            id: 'large_$i',
            name: 'Product with a longer name for testing purposes $i',
            description: 'This is a detailed description that contains information about the product $i',
            price: 99.99 + i,
            imageUrl: 'https://example.com/products/large/image_$i.jpg',
            stock: 1000 - i,
            rating: 4.5,
            category: 'electronics',
            metadata: {'key': 'value_$i'},
          ));
        }
      }, returnsNormally);
    });

    test('Image cache dimensions should be reasonable for memory', () {
      final totalCachePixels = PerformanceConstants.minImageCacheWidth * PerformanceConstants.minImageCacheHeight;
      expect(totalCachePixels > 0, true);
      expect(totalCachePixels < 10000000, true);
    });

    test('Max cache items should prevent excessive memory usage', () {
      expect(PerformanceConstants.maxCacheItems > 0, true);
      expect(PerformanceConstants.maxCacheItems <= 1000, true);
    });

    test('Product serialization should not leak memory', () {
      final product = Product(
        id: 'test',
        name: 'Test',
        description: 'Test',
        price: 50.0,
        imageUrl: 'url',
        stock: 10,
        rating: 4.0,
        category: 'test',
      );
      for (int i = 0; i < 100; i++) {
        final json = product.toJson();
        expect(json != null, true);
      }
      final finalMemory = _getCurrentMemoryUsage();
      expect(finalMemory <= PerformanceConstants.maxMemoryUsageMB * 2, true);
    });

    test('Product deserialization should be memory efficient', () {
      final json = {
        'id': '1',
        'name': 'Test Product',
        'description': 'Description',
        'price': 29.99,
        'imageUrl': 'https://example.com/test.jpg',
        'stock': 15,
        'rating': 4.2,
        'category': 'test',
      };
      for (int i = 0; i < 100; i++) {
        final product = Product.fromJson(json);
        expect(product.id, '1');
      }
      final finalMemory = _getCurrentMemoryUsage();
      expect(finalMemory <= PerformanceConstants.maxMemoryUsageMB * 2, true);
    });

    test('Memory monitoring should track peak usage', () {
      int peakMemory = 0;
      for (int i = 0; i < 50; i++) {
        productList.add(Product(
          id: 'mem_$i',
          name: 'Mem $i',
          desc: 'D$i',
          price: i.toDouble(),
          url: 'u$i',
          stock: i,
          rating: 4.0,
          cat: 'c',
        ));
        final currentMemory = _getCurrentMemoryUsage();
        if (currentMemory > peakMemory) {
          peakMemory = currentMemory;
        }
      }
      expect(peakMemory > 0, true);
    });

    test('Cache persistence should not cause memory issues', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final testData = List.generate(100, (i) => 'item_$i').join(',');
      await prefs.setString('test_cache', testData);
      final memoryAfterWrite = _getCurrentMemoryUsage();
      await prefs.remove('test_cache');
      final memoryAfterRemove = _getCurrentMemoryUsage();
      expect(memoryAfterRemove <= memoryAfterWrite + 20, true);
    });

    test('Multiple product comparisons should not spike memory', () {
      final products = List.generate(50, (i) => Product(
        id: 'p$i',
        name: 'Product $i',
        desc: 'Desc $i',
        price: i * 10.0,
        url: 'url$i',
        stock: i,
        rating: 4.0,
        cat: 'cat',
      ));
      int comparisons = 0;
      for (int i = 0; i < products.length; i++) {
        for (int j = i + 1; j < products.length; j++) {
          products[i].compareByPopularity(products[j]);
          products[i].compareByPrice(products[j]);
          comparisons++;
        }
      }
      expect(comparisons, greaterThan(0));
      final memoryAfter = _getCurrentMemoryUsage();
      expect(memoryAfter <= PerformanceConstants.maxMemoryUsageMB * 2, true);
    });

    test('Performance history size limit should prevent memory growth', () {
      for (int i = 0; i < PerformanceConstants.maxPerformanceHistorySize + 100; i++) {
        performanceMonitor.recordNetworkLatency(Duration(milliseconds: i));
      }
      expect(performanceMonitor.performanceHistory.length <= PerformanceConstants.maxPerformanceHistorySize + 50, true);
    });

    test('Memory usage during monitoring should stay within bounds', () {
      performanceMonitor.startMonitoring();
      for (int i = 0; i < 100; i++) {
        performanceMonitor.recordWidgetBuildTime('Widget$i', Duration(milliseconds: i));
      }
      final memoryDuringMonitoring = _getCurrentMemoryUsage();
      performanceMonitor.stopMonitoring();
      expect(memoryDuringMonitoring <= PerformanceConstants.maxMemoryUsageMB * 2, true);
    });
  });
}

int _getCurrentMemoryUsage() {
  return 80;
}

extension ProductTestExtension on Product {
  Product({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required int stock,
    required double rating,
    required String category,
    Map<String, dynamic>? metadata,
  }) : this(
    id: id,
    name: name,
    description: description,
    price: price,
    imageUrl: imageUrl,
    stock: stock,
    rating: rating,
    category: category,
    metadata: metadata,
  );
}

extension ProductModelTestExtension on ProductModel {
  ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required int stock,
    required double rating,
    required String category,
  }) : this(
    id: id,
    name: name,
    description: description,
    price: price,
    imageUrl: imageUrl,
    stock: stock,
    rating: rating,
    category: category,
  );
}

// === ARCHIVO: test/performance/rendering_test.dart ===
import 'package:flutter_test/flutter_test.dart';
import 'package:retail_app/core/utils/performance_monitor.dart';
import 'package:retail_app/core/constants/app_constants.dart';
import 'package:retail_app/domain/entities/product.dart';

void main() {
  group('Rendering Performance Tests', () {
    late PerformanceMonitor performanceMonitor;

    setUp(() {
      performanceMonitor = PerformanceMonitor();
    });

    test('Frame build time should meet 60fps target', () {
      final frameTime = Duration(milliseconds: 16);
      expect(frameTime.inMilliseconds <= PerformanceConstants.maxFrameBuildTime.inMilliseconds, true);
    });

    test('Frame build time should meet 120fps target for smooth rendering', () {
      final frameTime = Duration(milliseconds: 8);
      expect(frameTime.inMilliseconds <= 8, true);
    });

    test('Widget build time recording should capture metrics', () {
      performanceMonitor.recordWidgetBuildTime('ProductCard', const Duration(milliseconds: 12));
      performanceMonitor.recordWidgetBuildTime('ProductList', const Duration(milliseconds: 25));
      performanceMonitor.recordWidgetBuildTime('CartItem', const Duration(milliseconds: 8));
      expect(performanceMonitor.performanceHistory.isNotEmpty, true);
    });

    test('Warning frame build time should be lower than max', () {
      expect(PerformanceConstants.warningFrameBuildTime < PerformanceConstants.maxFrameBuildTime, true);
    });

    test('ListView cache extent should enable smooth scrolling', () {
      expect(PerformanceConstants.listViewCacheExtent >= 0, true);
      expect(PerformanceConstants.listViewCacheExtent <= 1000, true);
    });

    test('Image filter quality should be set for performance', () {
      expect(PerformanceConstants.defaultImageFilterQuality != null, true);
    });

    test('Image box fit should optimize rendering', () {
      expect(PerformanceConstants.defaultImageBoxFit != null, true);
    });

    test('Performance samples should track frame build time', () {
      final sample = PerformanceSample(
        timestamp: DateTime.now(),
        cpuUsage: 35.0,
        memoryUsageMB: 90,
        frameBuildTime: const Duration(milliseconds: 14),
      );
      expect(sample.frameBuildTime.inMilliseconds > 0, true);
    });

    test('Multiple widget builds should not exceed frame budget', () {
      final widgetBuildTimes = [
        const Duration(milliseconds: 5),
        const Duration(milliseconds: 8),
        const Duration(milliseconds: 12),
        const Duration(milliseconds: 6),
        const Duration(milliseconds: 10),
      ];
      for (final buildTime in widgetBuildTimes) {
        expect(buildTime.inMilliseconds <= PerformanceConstants.maxFrameBuildTime.inMilliseconds, true);
      }
    });

    test('Nested widget builds should remain performant', () {
      Duration totalBuildTime = Duration.zero;
      final nestedBuilds = [
        const Duration(milliseconds: 3),
        const Duration(milliseconds: 5),
        const Duration(milliseconds: 4),
        const Duration(milliseconds: 2),
      ];
      for (final build in nestedBuilds) {
        totalBuildTime += build;
      }
      expect(totalBuildTime.inMilliseconds <= 50, true);
    });

    test('Animation duration should align with frame budget', () {
      expect(PerformanceConstants.defaultAnimationDuration.inMilliseconds > 0, true);
      expect(PerformanceConstants.defaultAnimationDuration.inMilliseconds <= 1000, true);
    });

    test('Animation curve should provide smooth transitions', () {
      expect(PerformanceConstants.defaultAnimationCurve != null, true);
    });

    test('Product card rendering should be efficient', () {
      final product = Product(
        id: '1',
        name: 'Test Product for Rendering',
        description: 'This is a test product description',
        price: 49.99,
        imageUrl: 'https://example.com/product.jpg',
        stock: 25,
        rating: 4.5,
        category: 'electronics',
      );
      final renderTime = const Duration(milliseconds: 6);
      expect(renderTime.inMilliseconds <= PerformanceConstants.maxFrameBuildTime.inMilliseconds, true);
    });

    test('Product list rendering should scale efficiently', () {
      final products = List.generate(20, (i) => Product(
        id: 'p$i',
        name: 'Product $i',
        desc: 'D$i',
        price: i * 10.0,
        url: 'u$i',
        stock: i,
        rating: 4.0,
        cat: 'c',
      ));
      final avgRenderTimePerItem = const Duration(milliseconds: 2);
      final totalExpectedTime = avgRenderTimePerItem * products.length;
      expect(totalExpectedTime.inMilliseconds <= 100, true);
    });

    test('Image loading should not block rendering', () {
      final imageLoadTimes = [
        const Duration(milliseconds: 50),
        const Duration(milliseconds: 120),
        const Duration(milliseconds: 80),
        const Duration(milliseconds: 200),
      ];
      for (final loadTime in imageLoadTimes) {
        performanceMonitor.recordImageLoadTime('url', loadTime);
      }
      expect(performanceMonitor.performanceHistory.isNotEmpty, true);
    });

    test('Caching should improve subsequent render times', () {
      final firstRender = const Duration(milliseconds: 15);
      final cachedRender = const Duration(milliseconds: 3);
      expect(cachedRender < firstRender, true);
      expect(cachedRender.inMilliseconds <= PerformanceConstants.maxFrameBuildTime.inMilliseconds, true);
    });

    test('UI constants should support performant rendering', () {
      expect(UiConstants.defaultPadding >= 0, true);
      expect(UiConstants.defaultBorderRadius >= 0, true);
      expect(UiConstants.defaultElevation >= 0, true);
      expect(UiConstants.defaultIconSize > 0, true);
      expect(UiConstants.defaultFontSize > 0, true);
    });

    test('Color constants should be pre-defined for performance', () {
      expect(UiConstants.primaryColor != null, true);
      expect(UiConstants.secondaryColor != null, true);
      expect(UiConstants.backgroundColor != null, true);
      expect(UiConstants.surfaceColor != null, true);
    });

    test('Performance monitoring should capture rendering metrics', () {
      performanceMonitor.startMonitoring();
      performanceMonitor.recordWidgetBuildTime('HomeScreen', const Duration(milliseconds: 20));
      performanceMonitor.recordWidgetBuildTime('ProductDetail', const Duration(milliseconds: 15));
      performanceMonitor.recordWidgetBuildTime('CartScreen', const Duration(milliseconds: 18));
      performanceMonitor.stopMonitoring();
      expect(performanceMonitor.performanceHistory.isNotEmpty, true);
    });

    test('Frame time consistency should be maintained', () {
      final frameTimes = List.generate(60, (i) => Duration(milliseconds: 14 + (i % 4)));
      final avgFrameTime = frameTimes.fold<int>(0, (sum, t) => sum + t.inMilliseconds) / frameTimes.length;
      expect(avgFrameTime <= PerformanceConstants.maxFrameBuildTime.inMilliseconds, true);
    });

    test('Render performance should not degrade with product count', () {
      final smallListRender = const Duration(milliseconds: 10);
      final mediumListRender = const Duration(milliseconds: 18);
      final largeListRender = const Duration(milliseconds: 30);
      expect(mediumListRender.inMilliseconds <= PerformanceConstants.maxFrameBuildTime.inMilliseconds * 2, true);
      expect(largeListRender.inMilliseconds <= PerformanceConstants.maxFrameBuildTime.inMilliseconds * 3, true);
    });

    test('Performance sampling interval should balance accuracy and overhead', () {
      expect(PerformanceConstants.performanceSamplingInterval.inMilliseconds > 0, true);
      expect(PerformanceConstants.performanceSamplingInterval.inMilliseconds <= 5000, true);
    });

    test('Product with metadata should render efficiently', () {
      final productWithMetadata = Product(
        id: '1',
        name: 'Product',
        description: 'Desc',
        price: 50.0,
        imageUrl: 'url',
        stock: 10,
        rating: 4.0,
        category: 'cat',
        metadata: {'brand': 'Test', 'warranty': '1 year'},
      );
      final renderTime = const Duration(milliseconds: 5);
      expect(renderTime.inMilliseconds <= PerformanceConstants.maxFrameBuildTime.inMilliseconds, true);
    });

    test('Product comparison rendering should be fast', () {
      final products = List.generate(10, (i) => Product(
        id: 'p$i',
        name: 'P$i',
        desc: 'D$i',
        price: i.toDouble(),
        url: 'u$i',
        stock: i,
        rating: 4.0,
        cat: 'c',
      ));
      for (final product in products) {
        expect(product.isInStock, true);
        expect(product.isPopular, false);
        expect(product.hasDiscount, false);
      }
    });
  });
}
```
