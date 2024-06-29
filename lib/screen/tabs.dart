import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/filter_provider.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screen/cartscreen.dart';
import 'package:meal_app/screen/categories.dart';
import 'package:meal_app/screen/filter_screen.dart';
import 'package:meal_app/screen/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/provider/favorites_provider.dart';

final favoriteMealsProvider =
    StateNotifierProvider<FavoritesMealNotifier, List<Meal>>((ref) {
  return FavoritesMealNotifier();
});

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => const FilterScreen(),
        ),
      );
    } else if (identifier == 'cart') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CartScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    } else if (_selectedPageIndex == 2) {
      activePage = const CartScreen();
      activePageTitle = 'Your Cart';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onselectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
