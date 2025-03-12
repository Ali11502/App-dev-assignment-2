import 'package:flutter/material.dart';

class CategoryFilter extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategoryFilter({super.key, required this.onCategorySelected});

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  int selectedIndex = 0;
  final List<String> categories = [
    "All", "electronics", "jewelery", "men's clothing", "women's clothing"
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: selectedIndex == index,
              selectedColor: Colors.purple[100],
              onSelected: (selected) {
                setState(() {
                  selectedIndex = index;
                });

                widget.onCategorySelected(categories[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
