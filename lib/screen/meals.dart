import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screen/meal_details.dart';
import 'package:meal_app/widgets/meal_item.dart';

class MealScreen extends ConsumerWidget {
  const MealScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ......nothing here!',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.background),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try to select a different category!',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.background),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (context, meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Meals'),
      ),
      body: content,
    );
  }
}
