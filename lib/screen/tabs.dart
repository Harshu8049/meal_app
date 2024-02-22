import 'package:flutter/material.dart';
import 'package:meal_app/screen/categories.dart';
import 'package:meal_app/screen/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _slectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _slectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CategoriesScreen();
    var activePageTitle = 'Categories';
    if (_slectedPageIndex == 1) {
      activePage = const MealScreen(title: 'favourir', meals: []);
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
        appBar: AppBar(title: Text(activePageTitle)),
        body: activePage,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: ' categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'favourir'),
          ],
        ));
  }
}
