import 'package:member_apps/core/constants/service_menu_name.dart';

class ServiceMenuModel{

  final ServiceType type;

  // ignore: missing_return
  String get name{
    switch (this.type){
      case ServiceType.food:
        return ServiceMenuName.FOOD;
        break;
      case ServiceType.barber:
        return ServiceMenuName.BARBER;
        break;
      case ServiceType.karaoke:
        return ServiceMenuName.KARAOKE;
        break;
      case ServiceType.sport:
        return ServiceMenuName.SPORT;
        break;
    }
  }

  // ignore: missing_return
  String get imagePath{
    switch (this.type){
      case ServiceType.food:
        // TODO: Handle this case.
        return "";
        break;
      case ServiceType.barber:
        // TODO: Handle this case.
        break;
      case ServiceType.karaoke:
        // TODO: Handle this case.
        break;
      case ServiceType.sport:
        // TODO: Handle this case.
        break;
    }
  }

  ServiceMenuModel(this.type);

}

enum ServiceType{
  food, barber, karaoke, sport
}