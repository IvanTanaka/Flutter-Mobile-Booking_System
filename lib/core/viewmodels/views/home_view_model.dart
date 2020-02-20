
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  List<ServiceMenuModel> serviceMenus = [
    ServiceMenuModel(ServiceType.food),
    ServiceMenuModel(ServiceType.barber),
    ServiceMenuModel(ServiceType.karaoke),
    ServiceMenuModel(ServiceType.sport),
  ];
}