import 'package:flutter/material.dart';


class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.fastfood,
                    size: 30,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Meal App',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.set_meal, color: Theme.of(context).colorScheme.onSurface),
            title: Text('Categories', style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              onSelectScreen('categories');
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Theme.of(context).colorScheme.onSurface),
            title: Text('Favorites', style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              onSelectScreen('favorites');
            },
          ),
          ListTile(
            leading: Icon(Icons.filter_list, color: Theme.of(context).colorScheme.onSurface),
            title: Text('Filters', style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              onSelectScreen('filters');
            },
          ),
          Spacer(flex: 10,),
          ListTile(
            leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.onSurface),
            title: Text('Setting', style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              onSelectScreen('dashboard');
            },
          ),
        ], 
      ),
    );
  }
}