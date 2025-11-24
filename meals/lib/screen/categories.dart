import 'package:flutter/material.dart';

import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/wideget/category_grid_item.dart';
import 'package:meals/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen ({super.key, required this.ontoggleFavorite, required this.availableMeals});

  final void Function(Meal meal) ontoggleFavorite;
  final List<Meal> availableMeals;

  void _selectedCategory(BuildContext context, Category category) {
    final filteredMeal = availableMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Mealscreen(
          title: category.title,
          meals: filteredMeal,
          ontoggleFavorite: ontoggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
      GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          //availableCategories.map((category) => CategoryGridItem(category: category)).toList(),
          for (final category in availableCategories) 
            CategoryGridItem(
              category: category, 
              onSelectCategory: () {
                _selectedCategory(context, category);
            },),
        ],
      );
  }
}