
import 'package:member_apps/core/models/service_item_model.dart';
import 'package:member_apps/core/viewmodels/base_viewmodel.dart';

class HomeViewmodel extends BaseViewmodel {
  List<ServiceItemModel> serviceItems = [
    ServiceItemModel(ServiceItemType.food),
    ServiceItemModel(ServiceItemType.barber),
    ServiceItemModel(ServiceItemType.karaoke),
    ServiceItemModel(ServiceItemType.sport),
  ];
}