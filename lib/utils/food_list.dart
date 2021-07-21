import 'package:transloadit_recipes/defs/food.dart';

import '../main.dart';

class FoodList {
  static List<Food> _foodList = [];

  static updateFoodList(Food food) {
    _foodList.contains(food) ? _foodList.remove(food) : _foodList.add(food);
    if (controller != null) {
      controller!.setState!(() {});
    }
  }

  static get foodList {
    return _foodList;
  }
}
