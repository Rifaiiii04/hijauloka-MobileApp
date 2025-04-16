import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../widgets/plant_card.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plants = [
      Plant(
        name: 'Sansivera',
        image: 'assets/logo.jpg',  // Using an existing image
        price: 40000,
        description: 'Indoor plant that purifies air',
      ),
      Plant(
        name: 'Philodendron',
        image: 'assets/logo.jpg',  // Using an existing image
        price: 60000,
        description: 'Beautiful tropical plant',
      ),
      Plant(
        name: 'Asplenium nid',
        image: 'assets/logo.jpg',  // Using an existing image
        price: 30000,
        description: 'Bird\'s nest fern',
      ),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search plant',
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: true,
                  onSelected: (bool selected) {},
                  backgroundColor: const Color(0xFF08644C),
                  selectedColor: const Color(0xFF08644C),
                  labelStyle: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Indoor'),
                  selected: false,
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF08644C)),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Outdoor'),
                  selected: false,
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF08644C)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Bestsellers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: plants.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: PlantCard(plant: plants[index]),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Outdoor',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: Color(0xFF08644C),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: plants.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: PlantCard(plant: plants[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}