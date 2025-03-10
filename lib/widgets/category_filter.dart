import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController =
        Get.find<CategoryController>();

    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryItem("All", categoryController),
            _buildCategoryItem("Indoor", categoryController),
            _buildCategoryItem("Outdoor", categoryController),
          ],
        ));
  }

  Widget _buildCategoryItem(String category, CategoryController controller) {
    bool isSelected = controller.selectedCategory.value == category;
    return GestureDetector(
      onTap: () => controller.setCategory(category),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? const Color.fromARGB(255, 27, 81, 29) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 27, 81, 29)
                : Colors.grey,
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            fontFamily: "Poppins",
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
