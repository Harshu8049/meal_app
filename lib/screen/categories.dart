import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screen/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0,
      upperBound: 1,
      animationBehavior: AnimationBehavior.preserve,
      reverseDuration: const Duration(seconds: 2),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList(); //check true oir false

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealScreen(
              title: category.title,
              meals: filteredMeals,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
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
        builder: (context, child) => SlideTransition(
              position: Tween(begin: const Offset(0.3, 0.5), end: Offset(0, 0))
                  .animate(CurvedAnimation(
                      parent: _animationController, curve: Curves.bounceInOut)),
              child: child,
            ));
  }
}
