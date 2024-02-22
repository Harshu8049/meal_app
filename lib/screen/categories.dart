import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/screen/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList(); //check true oir false

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) =>
                MealScreen(title: category.title, meals: filteredMeals)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2, // sizing of the grid view item
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ), // 2 column //grid delgate use to control the layout of the grid
          children: [
            //availableCategory.map((category)) => categorygriditem(category : category) alternative of for
            for (final i in availableCategories)
              CategoryGridItem(
                category: i,
                onSelectCategory: () {
                  _selectCategory(context, i);
                },
              ),
          ]),
    );
  }
}
