import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/cart_provider.dart';
import 'package:meal_app/screen/paymentscreen.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  void _incrementQuantity(BuildContext context, WidgetRef ref, String mealId) {
    final cartProviderNotifier = ref.read(cartProvider.notifier);
    cartProviderNotifier.incrementMealQuantity(mealId);
  }

  void _decrementQuantity(BuildContext context, WidgetRef ref, String mealId) {
    final cartProviderNotifier = ref.read(cartProvider.notifier);
    cartProviderNotifier.decrementMealQuantity(mealId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartMeals = ref.watch(cartProvider);
    final totalAmount = cartMeals.fold<double>(0, (sum, meal) => sum + meal.price * meal.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartMeals.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(color: Colors.white),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartMeals.length,
                    itemBuilder: (ctx, index) {
                      final meal = cartMeals[index];
                      return ListTile(
                        leading: Image.network(meal.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(meal.title),
                        subtitle: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                _decrementQuantity(context, ref, meal.id);
                              },
                            ),
                            Text('Quantity: ${meal.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                _incrementQuantity(context, ref, meal.id);
                              },
                            ),
                          ],
                        ),
                        trailing: Text('\$${meal.price.toStringAsFixed(2)}'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Total: \$${totalAmount.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentSummaryScreen(totalAmount: totalAmount),
                            ),
                          );
                        },
                        child: const Text('Make Payment'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
