import 'package:member_apps/core/constants/category_name.dart';
import 'package:member_apps/core/constants/food_category.dart';

class ServiceMenuModel{

  final String food_category;

  // ignore: missing_return
  String get name{
    switch (this.food_category){
      case FoodCategory.FAST_FOOD:
        return CategoryName.FAST_FOOD;
        break;
      case FoodCategory.SEA_FOOD:
        return CategoryName.SEA_FOOD;
        break;
      case FoodCategory.SALAD:
        return CategoryName.SALAD;
        break;
      case FoodCategory.DRINKS:
        return CategoryName.DRINKS;
        break;
    }
  }

  // ignore: missing_return
  String get imagePath{
    switch (this.food_category){
      case FoodCategory.FAST_FOOD:
        return "assets/images/fast_food.png";
        break;
      case FoodCategory.SEA_FOOD:
        return "assets/images/sea_food.png";
        break;
      case FoodCategory.SALAD:
        return "assets/images/salad.png";
        break;
      case FoodCategory.DRINKS:
        return "assets/images/drinks.png";
        break;
    }
  }

  ServiceMenuModel(this.food_category);

}

