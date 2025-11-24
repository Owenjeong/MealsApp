import 'package:flutter/material.dart';
// import 'package:meals/screen/main_drawer.dart';
// import 'package:meals/screen/tabs.dart';


enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FilterScreen> createState() => _FilterState();
}

class _FilterState extends State<FilterScreen> {

  bool _glutenfreeSetfilter = false;
  void _onChanged (bool newvalue) {
    setState(() {
      _glutenfreeSetfilter = newvalue;
    });
  }

  bool _lactosefreeSetfilter = false;
  void _lactosefreeSetchanged (bool newvalue) {
    setState(() {
      _lactosefreeSetfilter = newvalue;
    });
  }
  
  bool _vegetarianSetfilter = false;
  void _vegetarianSetchanged (bool newvalue) {
    setState(() {
      _vegetarianSetfilter = newvalue;
    });
  }

  bool _veganSetfilter = false;
  void _veganSetchanged (bool newvalue) {
    setState(() {
      _veganSetfilter = newvalue;
    });
  }

  @override
  void initState() {
    super.initState();
    _glutenfreeSetfilter = widget.currentFilters[Filter.glutenFree]!;
    _lactosefreeSetfilter = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianSetfilter = widget.currentFilters[Filter.vegetarian]!;
    _veganSetfilter = widget.currentFilters[Filter.vegan]!;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      // drawer: MainDrawer(onSelectScreen: 
      // (identifier) {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (ctx) => const TabScreen(),
      //     ),
      //   );
      // },),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if(didPop) return;
            Navigator.of(context).pop({
              Filter.glutenFree: _glutenfreeSetfilter,
              Filter.lactoseFree: _lactosefreeSetfilter,
              Filter.vegetarian: _vegetarianSetfilter,
              Filter.vegan: _veganSetfilter,
            });
          },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenfreeSetfilter, 
              onChanged: _onChanged,
              title: Text('Gluten-free', style: Theme.of(context).textTheme.titleMedium,),
              subtitle: Text('Only include gluten-free meals', style: Theme.of(context).textTheme.bodyMedium,),           
              activeColor: Theme.of(context).colorScheme.primary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
              SwitchListTile(
              value: _lactosefreeSetfilter, 
              onChanged: _lactosefreeSetchanged,
              title: Text('Lactose-free', style: Theme.of(context).textTheme.titleMedium,),
              subtitle: Text('Only include lactose-free meals', style: Theme.of(context).textTheme.bodyMedium,),           
              activeColor: Theme.of(context).colorScheme.primary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
                      SwitchListTile(
              value: _vegetarianSetfilter, 
              onChanged: _vegetarianSetchanged,
              title: Text('Vegetarian', style: Theme.of(context).textTheme.titleMedium,),
              subtitle: Text('Only include vegetarian meals', style: Theme.of(context).textTheme.bodyMedium,),           
              activeColor: Theme.of(context).colorScheme.primary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
                      SwitchListTile(
              value: _veganSetfilter, 
              onChanged: _veganSetchanged,
              title: Text('Vegan', style: Theme.of(context).textTheme.titleMedium,),
              subtitle: Text('Only include vegan meals', style: Theme.of(context).textTheme.bodyMedium,),           
              activeColor: Theme.of(context).colorScheme.primary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
