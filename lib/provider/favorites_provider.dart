import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';

class FavoritesMealNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealNotifier()
      : super(
            []); //colon use to intialize the list, use super to react out the parewnt class
  bool toggleMealFavoritesStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false; // if we add or delete the meal it again and again change the list of the meals mean add meal plus alll meal update again
    } else {
      state = [...state, meal];
      return true; //....is a spread operatore it mean contaian all meal which already and add new meal that is meal
    }
  }
}
