import 'package:flutter/material.dart';
import 'register_screen.dart';

class DigitCodeScreen extends StatelessWidget {
  const DigitCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
              },
              child:
                  const Icon(Icons.arrow_back_sharp, size: 30, color: Color.fromARGB(255, 8, 90, 5)),
            ),
            const SizedBox(height: 20),
            const Text(
              "Masukkan 4 digit kode yang sudah dikirim melalui",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
              textAlign: TextAlign.left,
            ),
            const Text(
              "SMS",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
                color: Color(0xFF08644C),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF08644C), width: 2),
                  ),
                  child: Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style:
                          const TextStyle(fontSize: 20, fontFamily: "Poppins"),
                      decoration: const InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  const Text(
                    "Kirim Ulang kode dalam 05.00",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman berikutnya setelah kode dikonfirmasi
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF08644C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 50),
                    ),
                    child: const Text(
                      "Konfirmasi",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
