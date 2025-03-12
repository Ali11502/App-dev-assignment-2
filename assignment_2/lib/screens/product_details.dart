import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../model/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Hero(
              tag:  "product_${product.id}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.image,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Product Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                product.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Product Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "\$${product.price}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Product Rating with Stars
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  RatingBarIndicator(
                    rating: product.rating.rate.toDouble(),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    itemCount: 5,
                    itemSize: 18.0,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "(${product.rating.count})",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Product Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Text(
                product.description ?? "No description available.",
                style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
