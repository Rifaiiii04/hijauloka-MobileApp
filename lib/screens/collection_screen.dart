import 'package:flutter/material.dart';
import '../models/collection.dart';
import '../widgets/collection_card.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final collections = [
      Collection(
        name: 'Indoor Collection',
        image: 'assets/collection1.png',
        description: 'Beautiful collection of indoor plants',
        plants: [],
      ),
      // Add more collections as needed
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: collections.length,
      itemBuilder: (context, index) {
        return CollectionCard(collection: collections[index]);
      },
    );
  }
}