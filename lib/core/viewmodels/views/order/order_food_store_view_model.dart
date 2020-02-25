import 'package:member_apps/core/services/store_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class OrderFoodStoreViewModel extends BaseViewModel {
  DateTime _orderDate;
  DateTime get orderDate => _orderDate;
  DateTime get minOrderDate => DateTime.now().add(Duration(minutes: 15));
  DateTime get maxOrderDate => DateTime.now().add(Duration(days: 7));

  set orderDate(DateTime dateTime) {
    _storeService.orderDate = dateTime;
    _orderDate = dateTime;
    notifyListeners();
  }

  StoreService _storeService;

  OrderFoodStoreViewModel({StoreService storeService}) {
    this._storeService = storeService;
  }
}
