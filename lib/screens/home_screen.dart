import 'package:flutter/material.dart';
import '../widgets/category_filter.dart';
import '../widgets/banner.dart';
import '../widgets/custom_app_bar.dart'; // Import the CustomAppBar

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchActive = false;
  String _selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onSearchFocusChange);
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onSearchFocusChange);
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchFocusChange() {
    setState(() {
      _isSearchActive = _searchFocusNode.hasFocus;
    });
  }

  void _setCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar( // Replace AppBar with CustomAppBar
        searchFocusNode: _searchFocusNode,
        isSearchActive: _isSearchActive,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CategoryFilter(
            selectedCategory: _selectedCategory,
            onCategorySelected: _setCategory,
          ),
          const SizedBox(height: 20),
          const BannerWidget(),
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
          _buildPlantList(),
        ],
      ),
    );
  }

  Widget _buildPlantList() {
    // Simulate different plant lists based on the selected category
    List<String> plants = [];
    if (_selectedCategory == "All") {
      plants = ["Plant 1", "Plant 2", "Plant 3", "Plant 4"];
    } else if (_selectedCategory == "Indoor") {
      plants = ["Indoor Plant 1", "Indoor Plant 2"];
    } else if (_selectedCategory == "Outdoor") {
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