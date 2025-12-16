import 'package:my_exercise/exercise_12/rating.dart';

class Product {
  int id;
  String title;
  dynamic price;
  String description;
  String category;
  String image;
  Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        price: json["price"] ?? 0,
        description: json["description"] ?? "",
        category: json["category"] ?? "",
        image: json["image"] ?? "",
        rating: Rating.fromJson(json["rating"] ?? {'rate': 0, 'count': 0}),
      );
}