import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/models/order_cart_model.dart';
import 'package:member_apps/core/services/api.dart';

class OrderService{

  DateTime orderDate;
  List<OrderCartModel> _orderBody;
  List<OrderCartModel> get carts => _orderBody;
  set carts(List<OrderCartModel> carts){
    this._orderBody = carts;
  }

  Api _api;

  OrderService({Api api}){
    this._api =api;
  }

}