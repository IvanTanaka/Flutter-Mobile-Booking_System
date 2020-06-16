import 'package:flutter/material.dart';
import 'package:member_apps/core/constants/order_status.dart';
import 'package:member_apps/core/models/order_model.dart';
import 'package:member_apps/core/services/order_service.dart';
import 'package:member_apps/core/services/rate_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';
import 'package:member_apps/ui/shared_colors.dart';

class OrderFoodDetailViewModel extends BaseViewModel {
  OrderService _orderService;
  RateService _rateService;
  OrderModel orderModel;
  double star;

  Color get statusColor {
    switch(orderModel.status){
      case "waiting":
        return SharedColors.statusWaiting;
      case "accepted":
      case "finished":
        return SharedColors.statusSuccess;
      case "canceled":
      case "no_response":
      case "denied":
        return SharedColors.statusFailed;
    }
  }

  OrderFoodDetailViewModel({OrderService orderService, RateService rateService}) {
    this._orderService = orderService;
    this._rateService = rateService;
  }

  Future getOrderDetail({String id}) async {
    setBusy(true);
    orderModel = await _orderService.loadOrderDetail(id: id);
    setBusy(false);
  }

  Future cancelOrder() async {
    setBusy(true);
    if(orderModel.status == OrderStatus.WAITING){
      await _orderService.cancelOrder(id: orderModel.id);
    }
    setBusy(false);
  }

  Future finishOrder() async {
    setBusy(true);
    if(orderModel.status == OrderStatus.ACCEPTED){
      await _orderService.finishOrder(id: orderModel.id);
    }
    setBusy(false);
  }

  Future submitRate({String comment}) async{
    setBusy(true);
      _rateService.rate(orderId: orderModel.id, comment: comment, stars: star);
    setBusy(false);
  }

}
