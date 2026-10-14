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