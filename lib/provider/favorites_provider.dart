import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';

class FavoritesMealNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealNotifier() : super([]);

  bool toggleMealFavoritesStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoritesMealNotifier, List<Meal>>((ref) {
  return FavoritesMealNotifier();
});
