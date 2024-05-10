import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductModel {
  final String genre;
  final String title;
  final double rating;
  final String description;
  final int age;
  ProductModel({
    required this.genre,
    required this.title,
    required this.rating,
    required this.description,
    required this.age,
  });

  ProductModel copyWith({
    String? genre,
    String? title,
    double? rating,
    String? description,
    int? age,
  }) {
    return ProductModel(
      genre: genre ?? this.genre,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'genre': genre,
      'title': title,
      'rating': rating,
      'description': description,
      'age': age,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      genre: (map['genre'] ?? '') as String,
      title: (map['title'] ?? '') as String,
      rating: (map['rating'] ?? 0.0) as double,
      description: (map['description'] ?? '') as String,
      age: (map['age'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(genre: $genre, title: $title, rating: $rating, description: $description, age: $age)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.genre == genre && other.title == title && other.rating == rating && other.description == description && other.age == age;
  }

  @override
  int get hashCode {
    return genre.hashCode ^ title.hashCode ^ rating.hashCode ^ description.hashCode ^ age.hashCode;
  }
}
