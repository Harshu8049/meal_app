import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';

class CartNotifier extends StateNotifier<List<Meal>> {
  CartNotifier() : super([]);

  void addToCart(Meal meal) {
    // Check if the meal is already in the cart
    final mealIndex = state.indexWhere((m) => m.id == meal.id);
    if (mealIndex >= 0) {
      // If the meal is already in the cart, increase its quantity
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == mealIndex)
            state[i].copyWith(quantity: state[i].quantity + 1)
          else
            state[i]
      ];
    } else {
      // If the meal is not in the cart, add it with quantity 1
      state = [...state, meal.copyWith(quantity: 1)];
    }
  }

  void removeFromCart(Meal meal) {
    state = state.where((m) => m.id != meal.id).toList();
  }

  void incrementMealQuantity(String mealId) {
    state = [
      for (final meal in state)
        if (meal.id == mealId)
          meal.copyWith(quantity: meal.quantity + 1)
        else
          meal,
    ];
  }

  void decrementMealQuantity(String mealId) {
    state = [
      for (final meal in state)
        if (meal.id == mealId && meal.quantity > 1)
          meal.copyWith(quantity: meal.quantity - 1)
        else
          meal,
    ];
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<Meal>>((ref) => CartNotifier());
