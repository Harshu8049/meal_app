import 'package:flutter/material.dart';

enum Filter { glutenFree, lactoseFree, vegterian, vegan }

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilter});
  final Map<Filter, bool> currentFilter;
  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilter = false;
  var _vegtarianFilter = false;
  var _vegianFilter = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilter[Filter.glutenFree]!;
    _lactoseFreeFilter = widget.currentFilter[Filter.lactoseFree]!;
    _vegianFilter = widget.currentFilter[Filter.vegan]!;
    _vegtarianFilter = widget.currentFilter[Filter.vegterian]!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filter'),
      ),
      // drawer: MainDrawer(onselectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushre(
      //       MaterialPageRoute(
      //         builder: (ctx) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilter,
            Filter.vegan: _vegianFilter,
            Filter.vegterian: _vegtarianFilter,
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (ischecked) {
                setState(() {
                  _glutenFreeFilterSet = ischecked;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text('Only include Gluten-free Meals.',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactoseFreeFilter,
              onChanged: (ischecked) {
                setState(() {
                  _lactoseFreeFilter = ischecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text('Only include Lactose-free Meals.',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegtarianFilter,
              onChanged: (ischecked) {
                setState(() {
                  _vegtarianFilter = ischecked;
                });
              },
              title: Text(
                'Vegiterian-Filter',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text('Only include Vegiterian Meals.',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegianFilter,
              onChanged: (ischecked) {
                setState(() {
                  _vegianFilter = ischecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text('Only include Vegan Meals.',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
