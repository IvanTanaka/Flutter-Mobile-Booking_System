import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/services/api.dart';

class OrderService{

  DateTime orderDate;
  Api _api;

  OrderService({Api api}){
    this._api =api;
  }

}