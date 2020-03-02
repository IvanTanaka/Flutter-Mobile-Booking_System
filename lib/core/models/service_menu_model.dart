import 'package:member_apps/core/constants/booking_service_menu_name.dart';
import 'package:member_apps/core/enumerations/booking_service_type.dart';

class ServiceMenuModel{

  final BookingServiceType type;

  // ignore: missing_return
  String get name{
    switch (this.type){
      case BookingServiceType.food:
        return BookingServiceMenuName.FOOD;
        break;
      case BookingServiceType.barber:
        return BookingServiceMenuName.BARBER;
        break;
      case BookingServiceType.karaoke:
        return BookingServiceMenuName.KARAOKE;
        break;
      case BookingServiceType.sport:
        return BookingServiceMenuName.SPORT;
        break;
    }
  }

  // ignore: missing_return
  String get imagePath{
    switch (this.type){
      case BookingServiceType.food:
        // TODO: Handle this case.
        return "";
        break;
      case BookingServiceType.barber:
        // TODO: Handle this case.
        break;
      case BookingServiceType.karaoke:
        // TODO: Handle this case.
        break;
      case BookingServiceType.sport:
        // TODO: Handle this case.
        break;
    }
  }

  ServiceMenuModel(this.type);

}

