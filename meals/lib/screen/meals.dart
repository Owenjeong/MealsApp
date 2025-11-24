import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/wideget/meal_item.dart';
import 'package:meals/screen/meal_item_detail.dart';

class Mealscreen extends StatelessWidget {
  const Mealscreen({super.key, this.title, required this.meals, required this.ontoggleFavorite});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) ontoggleFavorite;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealItemDetail(meal: meal, ontoggleFavorite: ontoggleFavorite,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          return MealItem(meal: meals[index], onSelectMeal: (context, meal) {
            selectMeal(context, meal);
          },);
        }
      );

      if (meals.isEmpty) {
        content = Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Uh oh ... nothing here!', style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              const SizedBox(height: 16),
              Text('Try selecting a different category!', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7)),),
            ],
          ),
        );
      }
    
    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}