import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screen/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/favorites_provider.dart';
class MealDetailsScreen extends ConsumerStatefulWidget {
  const MealDetailsScreen({super.key, required this.meal});
  final Meal meal;

  @override
  ConsumerState<MealDetailsScreen> createState() {
    return _MealDetailsScreen();
  }
}

class _MealDetailsScreen extends ConsumerState<MealDetailsScreen> {
  late SharedPreferences prefs;

  var x = 1;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      x = prefs.getInt('x') ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? star;
    if (x == 1) {
      star = const Icon(Icons.star_border);
    } else if (x == 0) {
      star = const Icon(Icons.star);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(favoriteMealsProvider.notifier);
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
