import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/models/order_cart_model.dart';
import 'package:member_apps/core/models/order_model.dart';
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

  Future<String> submitOrder({String storeId, int total, int dineInQty, DateTime orderDate}) async {
    List cartStr = [];
    carts.forEach(($cart){
      cartStr.add($cart.toJson());
    });
    final response = await _api.post(url: "v1/order", body: {
      "carts": cartStr,
      "branch_id": storeId,
      "total": total,
      "people_count": dineInQty,
      "reserve_time": orderDate.toString(),
    });
    final resDecoded = json.decode(response);
    if (resDecoded["code"] == NetworkCode.SUCCESS) {
      print("ID ${resDecoded["result"]["id"]}");
      return resDecoded["result"]["id"];
    } else {
      throw(resDecoded["message"]);
    }
  }

  Future<OrderModel> loadOrderDetail({String id}) async {
    final response = await _api.get(
      url: "v1/order/$id",
    );
    final resDecoded = json.decode(response);
    if (resDecoded["code"] == NetworkCode.SUCCESS) {
      return OrderModel.fromJson(resDecoded['result']);
    } else {
      return OrderModel();
    }
  }
}