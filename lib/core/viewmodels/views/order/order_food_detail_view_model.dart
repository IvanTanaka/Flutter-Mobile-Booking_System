import 'package:flutter/material.dart';
import 'package:member_apps/core/models/order_model.dart';
import 'package:member_apps/core/services/order_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';
import 'package:member_apps/ui/shared_colors.dart';

class OrderFoodDetailViewModel extends BaseViewModel {
  OrderService _orderService;
  OrderModel orderModel;
  Color get statusColor {
    switch(orderModel.status){
      case "no_response":
      case "waiting":
        return SharedColors.statusWaiting;
      case "accepted":
      case "finished":
        return SharedColors.statusSuccess;
      case "canceled":
      case "denied":
        return SharedColors.statusFailed;
    }
  }

  OrderFoodDetailViewModel({OrderService orderService}) {
    this._orderService = orderService;
  }

  Future getOrderDetail({String id}) async {
    setBusy(true);
    orderModel = await _orderService.loadOrderDetail(id: id);
    setBusy(false);
  }

}
