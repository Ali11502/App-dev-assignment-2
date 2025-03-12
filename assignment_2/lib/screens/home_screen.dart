import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../provider/product_provider.dart';
import '../widgets/category_filter.dart';
import '../widgets/product_card.dart';
import '../widgets/shimmer_effect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isShimmering = true; // Controls shimmer effect
  List filteredProducts = []; // Holds filtered products
  String selectedCategory = "All"; // Default category

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (!mounted) return;

      // Fetch products
      await context.read<ProductProvider>().getAllProducts();

      // Keep shimmer effect for at least 2 seconds initially
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isShimmering = false;
          filteredProducts = context.read<ProductProvider>().products; // Show all products initially
        });
      }
    });
  }

  /// **Filters products and adds shimmer effect**
  void filterProducts(String category) async {
    setState(() {
      _isShimmering = true; // Start shimmer
      selectedCategory = category;
    });

    // Simulate loading time
    await Future.delayed(const Duration(seconds: 2));

    final productProvider = context.read<ProductProvider>();

    setState(() {
      if (category == "All") {
        filteredProducts = productProvider.products;
      } else {
        filteredProducts = productProvider.products
            .where((product) => product.category == category)
            .toList();
      }
      _isShimmering = false; // Stop shimmer
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text("Products"),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.search),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 10),

          // Pass filtering function to CategoryFilter
          CategoryFilter(onCategorySelected: filterProducts),

          const SizedBox(height: 10),
          Expanded(
            child: _isShimmering || productProvider.isLoading
                ? buildShimmerGrid() // Show shimmer when filtering
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.65,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductCard(product: product);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
