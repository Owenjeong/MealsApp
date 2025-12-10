import 'package:flutter/material.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/screen/categories.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screen/filter.dart';
import 'package:meals/screen/main_drawer.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};


class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showinfomessage (String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  } 

  void _toggleFavorite(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    setState(() {
      if (isExisting) {
          _favoriteMeals.remove(meal);
        _showinfomessage('Meal removed from favorites');
      } else {
          _favoriteMeals.add(meal);
        _showinfomessage('Meal added to favorites!');
      }
    });
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void setScreen (String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'categories') {
      _selectedPage(0);
    }
    else if (identifier == 'favorites') {
      _selectedPage(1);
    }
    else if (identifier == 'dashboard') {
      _selectedPage(2);
    }
    else if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(currentFilters: _selectedFilters,),
        ),
      );
      setState () {
        _selectedFilters = result ?? kInitialFilters;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableCategories = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();


    Widget activePage = CategoriesScreen(
    ontoggleFavorite: _toggleFavorite,
    availableMeals: availableCategories,
    );
    var activePageTitle = 'Categories';

      if (_selectedPageIndex == 1) {
        activePage = Mealscreen(meals: _favoriteMeals, ontoggleFavorite: _toggleFavorite,);
        activePageTitle = 'Your Favorites';
      }
      else if (_selectedPageIndex == 2) {
        activePage = const Center(
          child: Text('Dashboard Screen'),
        );
        activePageTitle = 'Dashboard';
      }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        // mouseCursor: MouseCursor.defer,
        onTap: _selectedPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
            activeIcon: Icon(Icons.set_meal_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Favorites',
            activeIcon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
            activeIcon: Icon(Icons.dashboard_rounded),
          ),
        ],
      ),
    );
  }
}