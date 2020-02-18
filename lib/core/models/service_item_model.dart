import 'package:member_apps/core/constants/service_item_name.dart';

class ServiceItemModel{

  final ServiceItemType type;

  // ignore: missing_return
  String get name{
    switch (this.type){
      case ServiceItemType.food:
        return ServiceItemName.FOOD;
        break;
      case ServiceItemType.barber:
        return ServiceItemName.BARBER;
        break;
      case ServiceItemType.karaoke:
        return ServiceItemName.KARAOKE;
        break;
      case ServiceItemType.sport:
        return ServiceItemName.SPORT;
        break;
    }
  }

  // ignore: missing_return
  String get imagePath{
    switch (this.type){
      case ServiceItemType.food:
        // TODO: Handle this case.
        return "";
        break;
      case ServiceItemType.barber:
        // TODO: Handle this case.
        break;
      case ServiceItemType.karaoke:
        // TODO: Handle this case.
        break;
      case ServiceItemType.sport:
        // TODO: Handle this case.
        break;
    }
  }

  ServiceItemModel(this.type);

}

enum ServiceItemType{
  food, barber, karaoke, sport
}