import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/models/order_cart_model.dart';
import 'package:member_apps/core/models/order_model.dart';
import 'package:member_apps/core/services/api.dart';

class OrderService{

  DateTime orderDate;
  List<OrderCartModel> carts = [];

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
      this.orderDate = null;
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


  Future<List<OrderModel>> loadOrders({int page=1}) async {
    final response = await _api.get(
      url: "v1/order?page=$page",
    );
    final resDecoded = json.decode(response);
    if (resDecoded["code"] == NetworkCode.SUCCESS) {
      return List<OrderModel>.from(resDecoded["result"]["data"].map((x) => OrderModel.fromJson(x)));
    } else {
      return [];
    }
  }

  Future<OrderModel> cancelOrder({String id}) async {
    final response = await _api.post(
      url: "v1/order/$id/cancel",
    );
    final resDecoded = json.decode(response);
    if (resDecoded["code"] == NetworkCode.SUCCESS) {
      return OrderModel.fromJson(resDecoded['result']);
    } else {
      return OrderModel();
    }
  }

  Future<OrderModel> finishOrder({String id}) async {
    final response = await _api.post(
      url: "v1/order/$id/finish",
    );
    final resDecoded = json.decode(response);
    if (resDecoded["code"] == NetworkCode.SUCCESS) {
      return OrderModel.fromJson(resDecoded['result']);
    } else {
      return OrderModel();
    }
  }
}