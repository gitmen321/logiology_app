class ProductModel {
  final int id;
  final String title;
  final double price;
  final double rating;
  final String category;
  final List<String> tags;
  final String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.category,
    required this.tags,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      category: json['category'],
      tags: List<String>.from(json['tags'] ?? []),
      thumbnail: json['thumbnail'],
    );
  }
}