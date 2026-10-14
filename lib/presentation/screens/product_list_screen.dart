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