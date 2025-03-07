import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    List<String> categories = ["All", "Indoor", "Outdoor"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: categories.map((category) {
        return GestureDetector(
          onTap: () => onCategorySelected(category),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: selectedCategory == category
                  ? const Color(0xFF08644C)
                  : Colors.white,
              border: Border.all(color: const Color(0xFF08644C)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: selectedCategory == category
                    ? Colors.white
                    : const Color(0xFF08644C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}