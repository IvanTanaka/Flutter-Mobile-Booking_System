import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/models/topup_model.dart';
import 'package:member_apps/core/services/api.dart';

class TopupService {
  Api _api;

  List<TopupModel> topups = [];

  TopupService({Api api}) {
    this._api = api;
  }

  Future<List<TopupModel>> loadHistories({int page=1}) async {
    final response = await _api.get(
      url: "v1/topup?page=$page",
    );
    final resDecoded = json.decode(response);
    if (resDecoded["code"] == NetworkCode.SUCCESS) {
      topups =  List<TopupModel>.from(resDecoded["result"]["data"].map((x) => TopupModel.fromJson(x)));
      return topups;
    } else {
      return [];
    }
  }

  Future<TopupModel> topUp({int amount}) async {
    final response = await _api.post(
      url: "v1/topup",
      body: {
        "amount":amount
      }
    );
    final resDecoded = json.decode(response);
    if (resDecoded["code"] == NetworkCode.SUCCESS) {
      return TopupModel.fromJson(resDecoded['result']);
    } else {
      return TopupModel();
    }
  }

  Future<TopupModel> loadTopUp({String id}) async {
    final response = await _api.get(
      url: "v1/topup/$id",
    );
    final resDecoded = json.decode(response);
    if (resDecoded["code"] == NetworkCode.SUCCESS) {
      return TopupModel.fromJson(resDecoded['result']);
    } else {
      return TopupModel();
    }
  }
}
