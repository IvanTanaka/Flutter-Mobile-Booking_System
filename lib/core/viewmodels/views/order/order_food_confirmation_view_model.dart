import 'package:member_apps/core/models/order_cart_model.dart';
import 'package:member_apps/core/models/order_store_product_model.dart';
import 'package:member_apps/core/services/order_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class OrderFoodConfirmationViewModel extends BaseViewModel {
  OrderService _orderService;

  OrderFoodConfirmationViewModel({OrderService orderService}) {
    this._orderService = orderService;
  }

  List<OrderCartModel> get carts => _orderService.carts;
  DateTime get orderDate => _orderService.orderDate;

}
