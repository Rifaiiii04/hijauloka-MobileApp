import 'plant.dart';

class Collection {
  final String name;
  final String image;
  final String description;
  final List<Plant> plants;

  const Collection({
    required this.name,
    required this.image,
    required this.description,
    required this.plants,
  });
}