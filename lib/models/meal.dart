import 'package:flutter/material.dart';

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String affordability;
  final String complexity;
  final String imageUrl;
  final int duration;
  final List<String> ingredients;
  final String aboutMeal;
  final double price;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;
  final int quantity;

  Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.affordability,
    required this.complexity,
    required this.imageUrl,
    required this.duration,
    required this.ingredients,
    required this.aboutMeal,
    required this.price,
    required this.isGlutenFree,
    required this.isVegan,
    required this.isVegetarian,
    required this.isLactoseFree,
    this.quantity = 0,
  });

  Meal copyWith({
    String? id,
    List<String>? categories,
    String? title,
    String? affordability,
    String? complexity,
    String? imageUrl,
    int? duration,
    List<String>? ingredients,
    String? aboutMeal,
    double? price,
    bool? isGlutenFree,
    bool? isVegan,
    bool? isVegetarian,
    bool? isLactoseFree,
    int? quantity,
  }) {
    return Meal(
      id: id ?? this.id,
      categories: categories ?? this.categories,
      title: title ?? this.title,
      affordability: affordability ?? this.affordability,
      complexity: complexity ?? this.complexity,
      imageUrl: imageUrl ?? this.imageUrl,
      duration: duration ?? this.duration,
      ingredients: ingredients ?? this.ingredients,
      aboutMeal: aboutMeal ?? this.aboutMeal,
      price: price ?? this.price,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isVegan: isVegan ?? this.isVegan,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isLactoseFree: isLactoseFree ?? this.isLactoseFree,
      quantity: quantity ?? this.quantity,
    );
  }
}
