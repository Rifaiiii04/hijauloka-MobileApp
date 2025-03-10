import 'package:get/get.dart';

class CategoryController extends GetxController {
  var selectedCategory = "All".obs;

  void setCategory(String category) {
    selectedCategory.value = category;
  }
}
