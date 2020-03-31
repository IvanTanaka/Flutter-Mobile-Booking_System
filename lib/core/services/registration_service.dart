import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/constants/booking_service_menu_name.dart';
import 'package:member_apps/core/constants/shared_preference_key.dart';
import 'package:member_apps/core/enumerations/booking_service_type.dart';
import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/order_store_model.dart';
import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/models/user_model.dart';
import 'package:member_apps/core/services/api.dart';
import 'package:member_apps/ui/prototype_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationService {
  Api _api;

  RegistrationService({Api api}) {
    this._api = api;
  }

  Future<bool> register(
      {String name, String phoneNumber, String email, String password}) async {
    final response = await _api.post(url: "v1/register", body: {
      "name": name,
      "phone_number": phoneNumber,
      "email": email,
      "password": password,
    });
    final resDecoded = json.decode(response);
    if (resDecoded["code"] == NetworkCode.SUCCESS) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(SharedPreferenceKey.ACCESS_TOKEN, resDecoded["token"]);
      return resDecoded["success"];
    } else {
      return false;
    }
  }
}
