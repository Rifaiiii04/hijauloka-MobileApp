import 'package:flutter/material.dart';
import 'digit_code_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> acceptTerms = ValueNotifier<bool>(false);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                    ),
                    Text(
                      "HijauLoka",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF08644C),
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              _buildInputField("Full Name", false),
              const SizedBox(height: 12),
              _buildInputField("Nomor HP", false),
              const SizedBox(height: 12),
              _buildInputField("Password", true),
              const SizedBox(height: 12),
              _buildInputField("Confirm Password", true),
              const SizedBox(height: 8),
              ValueListenableBuilder<bool>(
                valueListenable: acceptTerms,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Checkbox(
                        value: value,
                        onChanged: (newValue) {
                          acceptTerms.value = newValue!;
                        },
                        activeColor: const Color(0xFF08644C),
                      ),
                      const Expanded(
                        child: Text(
                          "I accept the Terms & Conditions",
                          style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 15),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DigitCodeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF08644C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Already have an account? Sign In",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF08644C),
                      fontFamily: "Poppins"),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.black)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Or Sign up With",
                      style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.black)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton("assets/google.png"),
                  const SizedBox(width: 15),
                  _buildSocialButton("assets/facebook.png"),
                ],
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildInputField(String label, bool isPassword) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontFamily: "Poppins"),
        suffixIcon: isPassword
            ? const Icon(Icons.visibility_off,
                color: Color(0xFF08644C), size: 18)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF08644C)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
    );
  }

  static Widget _buildSocialButton(String assetPath) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF08644C)),
          borderRadius: BorderRadius.circular(6),
        ),
        child:
            Image.asset(assetPath, width: 25, height: 25, fit: BoxFit.contain),
      ),
    );
  }
}
