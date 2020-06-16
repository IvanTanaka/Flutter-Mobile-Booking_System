import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/models/order_model.dart';
import 'package:member_apps/core/services/api.dart';

class RateService {
  Api _api;

  RateService({Api api}) {
    this._api = api;
  }

  Future<OrderModel> rate(
      {String orderId, double stars, String comment}) async {
    final response = await _api.post(
      url: "v1/rating/$orderId",
      body: {
        "stars" : stars,
        "comment" : comment
      }
    );
    final resDecoded = json.decode(response);
    if (resDecoded["code"] == NetworkCode.SUCCESS) {
      return OrderModel.fromJson(resDecoded['result']);
    } else {
      return OrderModel();
    }
  }
}
