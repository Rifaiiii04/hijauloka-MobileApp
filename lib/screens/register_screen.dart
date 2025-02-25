import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> acceptTerms = ValueNotifier<bool>(false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Create Account", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
                  Text("PlantNet!", style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Color(0xFF08644C))),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildInputField("Full Name", "John Doe", false),
            const SizedBox(height: 15),
            _buildInputField("Email", "johndoe@gmail.com", false),
            const SizedBox(height: 15),
            _buildInputField("Password", "********", true),
            const SizedBox(height: 15),
            _buildInputField("Confirm Password", "********", true),
            const SizedBox(height: 10),
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
                    const Expanded(child: Text("I accept the Terms & Conditions")),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF08644C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                ),
                child: const Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text("Already have an account? Sign In", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF08644C))),
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Expanded(child: Divider(color: Colors.black)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Or Sign up With"),
                ),
                Expanded(child: Divider(color: Colors.black)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton("assets/google.png"),
                const SizedBox(width: 20),
                _buildSocialButton("assets/facebook.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildInputField(String label, String hint, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: isPassword ? const Icon(Icons.visibility_off, color: Color(0xFF08644C)) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF08644C)),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          ),
        ),
      ],
    );
  }

  static Widget _buildSocialButton(String assetPath) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF08644C)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(assetPath, width: 30, height: 30, fit: BoxFit.contain),
      ),
    );
  }
}