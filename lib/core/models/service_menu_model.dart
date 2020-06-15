import 'package:member_apps/core/constants/category_name.dart';
import 'package:member_apps/core/enumerations/booking_service_type.dart';

class ServiceMenuModel{

  final BookingServiceCategory type;

  // ignore: missing_return
  String get name{
    switch (this.type){
      case BookingServiceCategory.fast_food:
        return CategoryName.FAST_FOOD;
        break;
      case BookingServiceCategory.sea_food:
        return CategoryName.SEA_FOOD;
        break;
      case BookingServiceCategory.salad:
        return CategoryName.SALAD;
        break;
      case BookingServiceCategory.drinks:
        return CategoryName.DRINKS;
        break;
    }
  }

  // ignore: missing_return
  String get imagePath{
    switch (this.type){
      case BookingServiceCategory.fast_food:
        return "assets/images/fast_food.png";
        break;
      case BookingServiceCategory.sea_food:
        return "assets/images/sea_food.png";
        break;
      case BookingServiceCategory.salad:
        return "assets/images/salad.png";
        break;
      case BookingServiceCategory.drinks:
        return "assets/images/drinks.png";
        break;
    }
  }

  ServiceMenuModel(this.type);

}

