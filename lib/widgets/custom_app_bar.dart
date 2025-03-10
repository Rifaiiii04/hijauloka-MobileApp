import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_bar_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarController controller = Get.put(AppBarController());

  CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          backgroundColor: const Color(0xFF08644C),
          elevation: 0,
          title: _buildSearchBar(context),
          actions: controller.isSearchActive.value
              ? [] // Menghilangkan ikon saat search aktif
              : const [
                  Icon(Icons.shopping_cart_outlined, color: Colors.white),
                  SizedBox(width: 20),
                  Icon(Icons.notifications_none, color: Colors.white),
                  SizedBox(width: 20),
                  Icon(Icons.chat, color: Colors.white),
                  SizedBox(width: 20),
                ],
        ));
  }

  Widget _buildSearchBar(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: controller.isSearchActive.value
          ? MediaQuery.of(context).size.width * 0.9
          : MediaQuery.of(context).size.width * 0.6,
      child: TextField(
        focusNode: controller.searchFocusNode,
        style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: controller.isSearchActive.value
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    controller.closeSearch();
                  },
                )
              : null,
          hintText: "Search plant",
          hintStyle:
              const TextStyle(fontFamily: "Poppins", color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
