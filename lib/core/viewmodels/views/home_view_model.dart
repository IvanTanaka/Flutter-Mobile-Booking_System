
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/viewmodels/base_viewmodel.dart';

class HomeViewModel extends BaseViewmodel {
  List<ServiceMenuModel> serviceMenus = [
    ServiceMenuModel(ServiceMenuType.food),
    ServiceMenuModel(ServiceMenuType.barber),
    ServiceMenuModel(ServiceMenuType.karaoke),
    ServiceMenuModel(ServiceMenuType.sport),
  ];
}