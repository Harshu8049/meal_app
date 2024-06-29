import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/cart_provider.dart';
import 'package:meal_app/screen/tabs.dart';

class MealDetailsScreen extends ConsumerStatefulWidget {
  const MealDetailsScreen({Key? key, required this.meal}) : super(key: key);
  final Meal meal;

  @override
  ConsumerState<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends ConsumerState<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final cartMeals = ref.watch(cartProvider);
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final inCart = cartMeals.contains(widget.meal);
    final isFavorite = favoriteMeals.contains(widget.meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoritesStatus(widget.meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    wasAdded ? 'Added to favorites' : 'Removed from favorites'),
              ));
            },
            icon: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                child: child,
              ),
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: widget.meal.id,
                    child: Image.network(
                      widget.meal.imageUrl,
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About Meal',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.meal.aboutMeal,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Ingredients',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final ingredient in widget.meal.ingredients)
                              Text(
                                '- $ingredient',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Price',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${widget.meal.price.toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: inCart
                    ? () {
                        ref
                            .read(cartProvider.notifier)
                            .removeFromCart(widget.meal);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  '${widget.meal.title} removed from cart')),
                        );
                      }
                    : () {
                        ref.read(cartProvider.notifier).addToCart(widget.meal);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('${widget.meal.title} added to cart')),
                        );
                      },
                child: Text(inCart ? 'Remove from Cart' : 'Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
