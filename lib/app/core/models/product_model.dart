
import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductModel {
  final String genre;
  final String title;
  final double rating;
  final String description;
  final int age;
  final Color color;

  ProductModel({
    required this.color,
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
    Color? color,
  }) {
    return ProductModel(
      genre: genre ?? this.genre,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      age: age ?? this.age,
      color: color ?? this.color,
    );
  }

  @override
  String toString() {
    return 'ProductModel(genre: $genre, title: $title, rating: $rating, description: $description, age: $age, color: $color)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.genre == genre && other.title == title && other.rating == rating && other.description == description && other.age == age && color == other.color;
  }

  @override
  int get hashCode {
    return genre.hashCode ^ title.hashCode ^ rating.hashCode ^ description.hashCode ^ age.hashCode ^ color.hashCode;
  }
}
