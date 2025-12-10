import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals/screen/filter.dart';


class FilterNotifier extends StateNotifier<Map<String, bool>> {
  FilterNotifier(): super({
    Filter.glutenFree.name: false,
    Filter.lactoseFree.name: false,
    Filter.vegetarian.name: false,
    Filter.vegan.name: false,
  });
  void setFilter(String filterKey, bool isActive) {
    // state[filterKey] = isActive; // not avaible, it's mutable
    state = {...state}; // create a new map to notify listeners
  }
}
final filterProvider = StateNotifierProvider<FilterNotifier, Map<String, bool>>((ref) {
  return FilterNotifier();
});