import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../model/product.dart';
import '../screens/product_details.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) =>
                ProductDetailsScreen(product: product),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0), // Start from bottom
                  end: Offset.zero, // Move to normal position
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Product Title
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 6),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Product Price & Rating Row
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Product Price
                  Text(
                    "\$${product.price % 1 == 0 ? product.price.toInt() : product.price}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  // Product Rating using RatingBarIndicator
                  RatingBarIndicator(
                    rating: product.rating.rate.toDouble(),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    itemCount: 5,
                    itemSize: 14.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
