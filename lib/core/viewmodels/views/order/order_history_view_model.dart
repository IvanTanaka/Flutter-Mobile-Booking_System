import 'package:member_apps/core/models/order_model.dart';
import 'package:member_apps/core/services/order_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class OrderHistoryViewModel extends BaseViewModel {
  OrderService _orderService;
  List<OrderModel> orders = [];
  int _page = 0;

  OrderHistoryViewModel({OrderService orderService}) {
    this._orderService = orderService;
    _page = 0;
  }

  Future loadOrderHistories() async {
//    setBusy(true);
    _page++;
    List<OrderModel> temp = await _orderService.loadOrders(page: _page);
    orders.addAll(temp);
    if(temp.length>0){
      setBusy(false);
    }
  }

}
