import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';

const availableCategories = [
  Category(
    id: 'c1',
    title: 'Italian',
    color: Colors.purple,
  ),
  Category(
    id: 'c2',
    title: 'Quick & Easy',
    color: Colors.red,
  ),
  Category(
    id: 'c3',
    title: 'Hamburgers',
    color: Colors.orange,
  ),
  Category(
    id: 'c4',
    title: 'German',
    color: Colors.amber,
  ),
  Category(
    id: 'c5',
    title: 'Light & Lovely',
    color: Colors.blue,
  ),
  Category(
    id: 'c6',
    title: 'Exotic',
    color: Colors.green,
  ),
  Category(
    id: 'c7',
    title: 'Breakfast',
    color: Colors.lightBlue,
  ),
  Category(
    id: 'c8',
    title: 'Asian',
    color: Colors.lightGreen,
  ),
  Category(
    id: 'c9',
    title: 'French',
    color: Colors.pink,
  ),
  Category(
    id: 'c10',
    title: 'Summer',
    color: Colors.teal,
  )
];
final List<Meal> dummyMeals = [
  Meal(
    id: 'm1',
    categories: ['c1', 'c2'],
    title: 'Spaghetti with Tomato Sauce',
    affordability: 'affordable',
    complexity: 'simple',
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
    duration: 20,
    ingredients: [
      '4 Tomatoes',
      '1 Tablespoon of Olive Oil',
      '1 Onion',
      '250g Spaghetti',
      'Spices',
      'Cheese (optional)'
    ],
    aboutMeal:
        'A classic Italian dish, spaghetti served with a rich tomato sauce, seasoned with spices and optionally topped with cheese.',
    price: 12.99,
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm2',
    categories: ['c2'],
    title: 'Toast Hawaii',
    affordability: "affordable",
    complexity: "simple",
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
    duration: 10,
    ingredients: [
      '1 Slice White Bread',
      '1 Slice Ham',
      '1 Slice Pineapple',
      '1-2 Slices of Cheese',
      'Butter'
    ],
    aboutMeal:
        'A quick and easy snack or light meal featuring toast topped with ham, pineapple, and cheese, baked to perfection.',
    price: 6.99,
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm3',
    categories: ['c2', 'c3'],
    title: 'Classic Hamburger',
    affordability: "pricey",
    complexity: "simple",
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    duration: 45,
    ingredients: [
      '300g Cattle Hack',
      '1 Tomato',
      '1 Cucumber',
      '1 Onion',
      'Ketchup',
      '2 Burger Buns'
    ],
    aboutMeal:
        'An iconic American burger made with fresh ingredients: beef patty, tomato, cucumber, onion, and ketchup, served in a soft bun.',
    price: 15.99,
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm4',
    categories: ['c4'],
    title: 'Wiener Schnitzel',
    affordability: "luxurious",
    complexity: "challenging",
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
    duration: 60,
    ingredients: [
      '8 Veal Cutlets',
      '4 Eggs',
      '200g Bread Crumbs',
      '100g Flour',
      '300ml Butter',
      '100g Vegetable Oil',
      'Salt',
      'Lemon Slices'
    ],
    aboutMeal:
        'A classic Austrian dish of tender veal cutlets, coated in breadcrumbs and fried until golden brown, served with lemon slices.',
    price: 24.99,
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm5',
    categories: ['c2', 'c5', 'c10'],
    title: 'Salad with Smoked Salmon',
    affordability: "luxurious",
    complexity: "simple",
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
    duration: 15,
    ingredients: [
      'Arugula',
      'Lamb\'s Lettuce',
      'Parsley',
      'Fennel',
      '200g Smoked Salmon',
      'Mustard',
      'Balsamic Vinegar',
      'Olive Oil',
      'Salt and Pepper'
    ],
    aboutMeal:
        'A luxurious salad featuring smoked salmon on a bed of fresh greens, dressed with mustard, balsamic vinegar, and olive oil.',
    price: 18.99,
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm6',
    categories: ['c6', 'c10'],
    title: 'Delicious Orange Mousse',
    affordability: "affordable",
    complexity: "hard",
    imageUrl:
        'https://cdn.pixabay.com/photo/2017/05/01/05/18/pastry-2274750_1280.jpg',
    duration: 240,
    ingredients: [
      '4 Sheets of Gelatine',
      '150ml Orange Juice',
      '80g Sugar',
      '300g Yoghurt',
      '200g Cream',
      'Orange Peel',
    ],
    aboutMeal:
        'A decadent dessert made with gelatine, orange juice, sugar, yogurt, and cream, topped with orange peel for a refreshing finish.',
    price: 14.99,
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm7',
    categories: ['c7'],
    title: 'Pancakes',
    affordability: "affordable",
    complexity: "simple",
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/10/21/23/pancake-3529653_1280.jpg',
    duration: 20,
    ingredients: [
      '1 1/2 Cups all-purpose Flour',
      '3 1/2 Teaspoons Baking Powder',
      '1 Teaspoon Salt',
      '1 Tablespoon White Sugar',
      '1 1/4 cups Milk',
      '1 Egg',
      '3 Tablespoons Butter, melted',
    ],
    aboutMeal:
        'A classic breakfast favorite, pancakes made with flour, baking powder, salt, sugar, milk, egg, and butter, served hot and fluffy.',
    price: 9.99,
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm8',
    categories: ['c8'],
    title: 'Creamy Indian Chicken Curry',
    affordability: "pricey",
    complexity: "challenging",
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/06/18/16/05/indian-food-3482749_1280.jpg',
    duration: 35,
    ingredients: [
      '4 Chicken Breasts',
      '1 Onion',
      '2 Cloves of Garlic',
      '1 Piece of Ginger',
      '4 Tablespoons Almonds',
      '1 Teaspoon Cayenne Pepper',
      '500ml Coconut Milk',
    ],
    aboutMeal:
        'An aromatic Indian curry made with tender chicken, onions, garlic, ginger, almonds, and coconut milk, served with rice.',
    price: 22.99,
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm9',
    categories: ['c9'],
    title: 'French Souffle',
    affordability: "luxurious",
    complexity: "hard",
    imageUrl:
        'https://cdn.pixabay.com/photo/2017/08/21/22/25/souffle-2667549_1280.jpg',
    duration: 45,
    ingredients: [
      '2 Egg Yolks',
      '2 Eggs',
      '1/2 Cup White Sugar',
      '1/4 Cup All-purpose Flour',
      '1/2 Cup Milk',
      '1/4 Cup Butter',
    ],
    aboutMeal:
        'A delicate French dessert souffle made with egg yolks, eggs, sugar, flour, milk, and butter, baked to fluffy perfection.',
    price: 20.99,
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm10',
    categories: ['c2', 'c5'],
    title: 'Healthy Salad with Quinoa',
    affordability: " affordable",
    complexity: "simple",
    imageUrl:
        'https://cdn.pixabay.com/photo/2017/06/16/11/38/salad-2405291_1280.jpg',
    duration: 20,
    ingredients: [
      '200g Quinoa',
      '1/2 Cucumber',
      '1 Red Pepper',
      '1/4 Red Onion',
      '1 Tablespoon Olive Oil',
      '1 Lemon',
      'Salt and Pepper',
    ],
    aboutMeal:
        'A nutritious salad featuring quinoa, cucumber, red pepper, and red onion, dressed with olive oil and lemon juice, seasoned to taste.',
    price: 16.99,
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
];
