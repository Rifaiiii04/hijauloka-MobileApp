import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/cart_item.dart';

class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;
  final RxDouble total = 0.0.obs;

  void addToCart(String name, double price, String image) {
    final existingItem = items.firstWhere(
      (item) => item.name == name,
      orElse: () => CartItem(name: name, price: price, image: image, quantity: 0),
    );

    if (existingItem.quantity == 0) {
      items.add(CartItem(name: name, price: price, image: image, quantity: 1));
    } else {
      final index = items.indexOf(existingItem);
      items[index] = CartItem(
        name: existingItem.name,
        price: existingItem.price,
        image: existingItem.image,
        quantity: existingItem.quantity + 1,
      );
    }
    
    calculateTotal();
    
    Get.snackbar(
      '',
      '',
      titleText: const SizedBox.shrink(),
      messageText: Row(
        children: [
          const Icon(Icons.shopping_cart, color: Colors.white),
          const SizedBox(width: 12),
          const Text(
            'Added to cart',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: const Color(0xFF08644C),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  void removeFromCart(CartItem item) {
    items.remove(item);
    calculateTotal();
  }

  void updateQuantity(CartItem item, int quantity) {
    final index = items.indexOf(item);
    if (index != -1) {
      if (quantity <= 0) {
        items.removeAt(index);
      } else {
        items[index] = CartItem(
          name: item.name,
          price: item.price,
          image: item.image,
          quantity: quantity,
        );
      }
      calculateTotal();
    }
  }

  void calculateTotal() {
    total.value = items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void clearCart() {
    items.clear();
    total.value = 0;
  }

  int get totalItems => items.length;
}