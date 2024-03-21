import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/meals_provider.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screen/categories.dart';
import 'package:meal_app/screen/filter_screen.dart';
import 'package:meal_app/screen/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/provider/favorites_provider.dart';

final favoriteMealsProvider =
    StateNotifierProvider<FavoritesMealNotifier, List<Meal>>((ref) {
  return FavoritesMealNotifier();
});
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegterian: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _slectedPageIndex = 0;

  Map<Filter, bool> _selectedFilter = kInitialFilters;
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Text(message),
      ),
    );
  }


  void _selectPage(int index) {
    setState(() {
      _slectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FilterScreen(
            currentFilter: _selectedFilter,
          ),
        ),
      );
      setState(() {
        _selectedFilter = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals =
        ref.watch(mealsProvider); //ref is like a widget in consumerstate

    final availableMeals = meals.where((meal) {
      if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilter[Filter.vegterian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';
    if (_slectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealScreen(
        meals: favoriteMeals,
      
      );
      activePageTitle = 'Your Favorites';
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
          currentIndex: _slectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: ' categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'favourir'),
          ],
        ));
  }
}
