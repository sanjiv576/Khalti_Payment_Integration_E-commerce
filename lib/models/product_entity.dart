import 'rating_entity.dart';

class ProductEntity {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingEntity rating;

  ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'].toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      rating: RatingEntity.fromJson(json['rating']),
    );
  }

  @override
  String toString() {
    return 'id: $id, title: $title, price: $price, description: $description, category: $category, image: $image rating: {rate: ${rating.rate}, count: ${rating.count}}';
  }
}
