import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

Widget buildShimmerGrid() {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      childAspectRatio: 0.65,
    ),
    itemCount: 6, // Show 6 shimmer placeholders
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[500]!,
        highlightColor: Colors.white,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    },
  );
}
