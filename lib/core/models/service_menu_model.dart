import 'package:member_apps/core/constants/service_menu_name.dart';

class ServiceMenuModel{

  final ServiceMenuType type;

  // ignore: missing_return
  String get name{
    switch (this.type){
      case ServiceMenuType.food:
        return ServiceMenuName.FOOD;
        break;
      case ServiceMenuType.barber:
        return ServiceMenuName.BARBER;
        break;
      case ServiceMenuType.karaoke:
        return ServiceMenuName.KARAOKE;
        break;
      case ServiceMenuType.sport:
        return ServiceMenuName.SPORT;
        break;
    }
  }

  // ignore: missing_return
  String get imagePath{
    switch (this.type){
      case ServiceMenuType.food:
        // TODO: Handle this case.
        return "";
        break;
      case ServiceMenuType.barber:
        // TODO: Handle this case.
        break;
      case ServiceMenuType.karaoke:
        // TODO: Handle this case.
        break;
      case ServiceMenuType.sport:
        // TODO: Handle this case.
        break;
    }
  }

  ServiceMenuModel(this.type);

}

enum ServiceMenuType{
  food, barber, karaoke, sport
}