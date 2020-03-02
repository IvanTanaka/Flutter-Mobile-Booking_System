
import 'package:member_apps/core/enumerations/booking_service_type.dart';
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  List<ServiceMenuModel> serviceMenus = [
    ServiceMenuModel(BookingServiceType.food),
    ServiceMenuModel(BookingServiceType.barber),
    ServiceMenuModel(BookingServiceType.karaoke),
    ServiceMenuModel(BookingServiceType.sport),
  ];
}