import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
