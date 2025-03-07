import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final FocusNode searchFocusNode;
  final bool isSearchActive;

  const CustomAppBar({
    super.key,
    required this.searchFocusNode,
    required this.isSearchActive,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: const Color(0xFF08644C),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      title: _buildSearchBar(context),
      actions: isSearchActive
          ? null
          : const [
              Icon(Icons.shopping_cart_outlined, color: Colors.white),
              SizedBox(width: 20),
              Icon(Icons.notifications_none, color: Colors.white),
              SizedBox(width: 20),
              Icon(Icons.chat, color: Colors.white),
              SizedBox(width: 20),
            ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isSearchActive
          ? MediaQuery.of(context).size.width * 1
          : MediaQuery.of(context).size.width * 0.6,
      child: TextField(
        focusNode: searchFocusNode,
        style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: isSearchActive
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => searchFocusNode.unfocus(),
                )
              : null,
          hintText: "Search plant",
          hintStyle: const TextStyle(fontFamily: "Poppins", color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
