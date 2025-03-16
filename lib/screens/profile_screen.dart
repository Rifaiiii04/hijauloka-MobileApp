import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Untuk memilih gambar
import 'dart:io'; // Untuk menangani file gambar
import 'package:http/http.dart' as http; // Untuk mengupload gambar
import 'dart:convert'; // Untuk encode/decode JSON
import 'login_screen.dart'; // Untuk logout

class ProfileScreen extends StatefulWidget {
  final String userEmail;
  final String userName;

  const ProfileScreen({
    super.key,
    required this.userEmail,
    required this.userName,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage; // File gambar profil
  final ImagePicker _picker = ImagePicker(); // Untuk memilih gambar

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      // Upload gambar ke server
      await _uploadImage(_profileImage!);
    }
  }

  // Fungsi untuk mengambil gambar dari kamera
  Future<void> _takeImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      // Upload gambar ke server
      await _uploadImage(_profileImage!);
    }
  }

  // Fungsi untuk menghapus gambar profil
  Future<void> _deleteImage() async {
    setState(() {
      _profileImage = null;
    });
    // Hapus gambar dari server
    await _deleteImageFromServer();
  }

  // Fungsi untuk mengupload gambar ke server
  Future<void> _uploadImage(File image) async {
    final url =
        Uri.parse('http://localhost/p_hijauloka/upload_profile_image.php');
    final request = http.MultipartRequest('POST', url)
      ..files
          .add(await http.MultipartFile.fromPath('profile_image', image.path))
      ..fields['email'] = widget.userEmail;

    final response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto profil berhasil diupload!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengupload foto profil!')),
      );
    }
  }

  // Fungsi untuk menghapus gambar dari server
  Future<void> _deleteImageFromServer() async {
    final url =
        Uri.parse('http://localhost/p_hijauloka/delete_profile_image.php');
    final response = await http.post(url, body: {
      'email': widget.userEmail,
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto profil berhasil dihapus!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghapus foto profil!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Stack(
          children: [
            Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFF08644C),
              ),
            ),
            Positioned(
              left: 16,
              top: 40,
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {},
              ),
            ),
            Positioned(
              right: 90,
              top: 40,
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.white),
                onPressed: () {},
              ),
            ),
            Positioned(
              right: 50,
              top: 40,
              child: IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.white),
                onPressed: () {},
              ),
            ),
            Positioned(
              right: 10,
              top: 40,
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
              Stack(
                children: [
                  ClipOval(
                    child: _profileImage != null
                        ? Image.file(
                            _profileImage!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 120,
                            height: 120,
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt,
                            color: Color(0xFF08644C)),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.photo_library),
                                  title: const Text('Pilih dari Galeri'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _pickImage();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text('Ambil Foto'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _takeImage();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.delete),
                                  title: const Text('Hapus Foto Profil'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _deleteImage();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.userName,
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
