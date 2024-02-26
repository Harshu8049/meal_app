import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen(
      {super.key, required this.meal, required this.onToogleFavorite});
  final Meal meal;
  final void Function(Meal meal) onToogleFavorite;
  @override
  State<StatefulWidget> createState() {
    return _MealDetailsScreen();
  }
}

class _MealDetailsScreen extends State<MealDetailsScreen> {
  var x = 1;

  @override
  Widget build(BuildContext context) {
    Widget? star;
    if (x == 1) {
      star = const Icon(Icons.star_border_outlined);
    } else if (x == 0) {
      star = const Icon(Icons.star);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (x == 0) {
                  x = 1;
                } else if (x == 1) {
                  x = 0;
                }
              });

              widget.onToogleFavorite(widget.meal);
            },
            icon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: star,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.meal.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingredients ',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final i in widget.meal.ingredients)
              Text(
                i,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final i in widget.meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  i,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
