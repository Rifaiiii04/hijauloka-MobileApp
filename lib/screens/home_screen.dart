import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';
import '../controllers/app_bar_controller.dart';
import '../controllers/user_controller.dart'; // Import UserController
import '../widgets/category_filter.dart';
import '../widgets/banner.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import 'profile_screen.dart'; // Import ProfileScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final CategoryController categoryController = Get.put(CategoryController());
  final AppBarController appBarController = Get.put(AppBarController());
  final UserController userController = Get.find(); // Akses UserController

  late List<Widget> _pages; // Deklarasikan _pages sebagai late

  @override
  void initState() {
    super.initState();
    // Inisialisasi _pages di sini
    _pages = [
      const HomeContent(), // Konten HomeScreen
      ProfileScreen(
        userEmail: userController.userEmail.value, // Email user yang login
        userName: userController.userName.value, // Nama user yang login
      ), // Halaman Profile
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _selectedIndex == 0
          ? CustomAppBar()
          : null, // Tampilkan AppBar hanya di Home
      body: _pages[_selectedIndex], // Tampilkan halaman sesuai indeks
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// Pisahkan konten HomeScreen ke dalam widget terpisah
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController = Get.find();
    final AppBarController appBarController = Get.find();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const BannerWidget(),
        const SizedBox(height: 20),
        const CategoryFilter(),
        const SizedBox(height: 20),
        const Text(
          "For You",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => _buildPlantList(categoryController.selectedCategory.value)),
      ],
    );
  }

  Widget _buildPlantList(String selectedCategory) {
    List<String> plants = [];
    if (selectedCategory == "All") {
      plants = ["Plant 1", "Plant 2", "Plant 3", "Plant 4"];
    } else if (selectedCategory == "Indoor") {
      plants = ["Indoor Plant 1", "Indoor Plant 2"];
    } else if (selectedCategory == "Outdoor") {
      plants = ["Outdoor Plant 1", "Outdoor Plant 2", "Outdoor Plant 3"];
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: plants.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage("assets/plant${index + 1}.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plants[index],
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Rp. 25.000",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Color.fromARGB(255, 27, 81, 29),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 27, 81, 29),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
