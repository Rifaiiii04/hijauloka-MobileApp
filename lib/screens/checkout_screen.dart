import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product.dart'; // Make sure this import exists

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Try-catch to handle potential errors with cart controller
    CartController cartController;
    try {
      cartController = Get.find<CartController>();
    } catch (e) {
      // If controller not found, create a new instance
      cartController = Get.put(CartController());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08644C),
        title: const Text('Cart'),
      ),
      body: _buildBody(cartController),
      bottomNavigationBar: _buildBottomBar(cartController),
    );
  }

  Widget _buildBody(CartController cartController) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderSummaryHeader(),
          const SizedBox(height: 16),
          _buildCartItemsList(cartController),
          const SizedBox(height: 24),
          _buildShippingAddressSection(),
          const SizedBox(height: 24),
          _buildOrderSummary(cartController),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryHeader() {
    return const Text(
      'Order Summary',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCartItemsList(CartController cartController) {
    return Obx(() {
      try {
        if (cartController.cartItems.isEmpty) {
          return const Center(
            child: Column(
              children: [
                Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('Your cart is empty', style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }
        
        // Use a safer approach to display cart items
        final items = cartController.cartItems.entries.toList();
        
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final entry = items[index];
            final product = entry.key;
            final quantity = entry.value;
            
            return Card(
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.spa, color: Color(0xFF08644C)),
                ),
                title: Text(product.name),
                subtitle: Text('Rp ${product.price}'),
                trailing: Text('x$quantity'),
              ),
            );
          },
        );
      } catch (e) {
        // Handle any unexpected errors
        return Center(
          child: Column(
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: ${e.toString()}', 
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
    });
  }

  Widget _buildShippingAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping Address',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Full Address',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildOrderSummary(CartController cartController) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal'),
              Obx(() {
                try {
                  return Text('Rp ${cartController.total.toStringAsFixed(0)}');
                } catch (e) {
                  return const Text('Rp 0');
                }
              }),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping'),
              Text('Rp 10.000'),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Obx(() {
                try {
                  return Text(
                    'Rp ${(cartController.total + 10000).toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF08644C),
                    ),
                  );
                } catch (e) {
                  return const Text(
                    'Rp 10.000',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF08644C),
                    ),
                  );
                }
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(CartController cartController) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Implement payment processing
            Get.snackbar(
              'Success',
              'Order placed successfully',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            cartController.cartItems.clear();
            Get.offAllNamed('/home');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF08644C),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Proceed to Payment'),
        ),
      ),
    );
  }
}