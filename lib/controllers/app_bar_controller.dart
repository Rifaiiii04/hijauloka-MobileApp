import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarController extends GetxController {
  final FocusNode searchFocusNode = FocusNode();
  var isSearchActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    searchFocusNode.addListener(() {
      isSearchActive.value = searchFocusNode.hasFocus;
    });
  }

  void closeSearch() {
    searchFocusNode.unfocus();
  }

  @override
  void onClose() {
    searchFocusNode.dispose();
    super.onClose();
  }
}
