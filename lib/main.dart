import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/login_screen.dart';
import 'screens/cart_screen.dart';  // Add this import
import 'controllers/user_controller.dart';
import 'controllers/cart_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CartController());
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: "Poppins"),
          bodyMedium: TextStyle(fontFamily: "Poppins"),
          bodySmall: TextStyle(fontFamily: "Poppins"),
        ),
      ),
      home: const LoginScreen(),
      getPages: [
        GetPage(
          name: '/cart',
          page: () => const CartScreen(),
        ),
      ],
    );
  }
}
