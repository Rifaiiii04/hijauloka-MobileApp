import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_screen.dart'; // Untuk logout

class ProfileScreen extends StatelessWidget {
  final String userEmail;
  final String userName;

  const ProfileScreen({
    super.key,
    required this.userEmail,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Stack(
          children: [
            Container(
              height: 100,
              decoration: const BoxDecoration(color: Color(0xFF08644C)),
            ),
            Positioned(
              left: 16,
              top: 25,
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {},
              ),
            ),
            Positioned(
              right: 90,
              top: 25,
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.white),
                onPressed: () {},
              ),
            ),
            Positioned(
              right: 50,
              top: 25,
              child: IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.white),
                onPressed: () {},
              ),
            ),
            Positioned(
              right: 10,
              top: 25,
              child: IconButton(
                icon: const Icon(Icons.chat, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              ClipOval(
                child: Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey[200],
                  child: const Icon(Icons.person, size: 60, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 4 / 2,
                children: [
                  buildStatusCard(Icons.account_balance_wallet, "Belum Bayar"),
                  buildStatusCard(Icons.inventory, "Dikemas"),
                  buildStatusCard(Icons.local_shipping, "Dikirim"),
                  buildStatusCard(Icons.star, "Ulasan"),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Aktivitas",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              buildMenuItem(context, Icons.favorite, "Daftar Keinginan"),
              const SizedBox(height: 10),
              buildDeleteAccount(context), // Delete Account Button
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF08644C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatusCard(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.teal, size: 22),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.teal, size: 28),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget buildDeleteAccount(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDeleteDialog(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.delete, color: Colors.red, size: 28),
            const SizedBox(width: 10),
            const Text(
              "Delete Account",
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hapus Akun"),
          content: const Text("Apakah Anda yakin ingin menghapus akun Anda?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAccount(context);
              },
              child: const Text("Hapus", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _deleteAccount(BuildContext context) async {
    final url = Uri.parse("http://localhost/p_hijauloka/delete_account.php");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": userEmail}),
      );

      print("Response: ${response.body}"); // Debugging: Lihat hasil dari API

      final responseData = jsonDecode(response.body);

      if (responseData['status'] == "success") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Gagal menghapus akun: ${responseData['message']}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}
