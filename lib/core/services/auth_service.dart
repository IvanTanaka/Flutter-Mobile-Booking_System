import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/constants/shared_preference_key.dart';
import 'package:member_apps/core/models/user_model.dart';
import 'package:member_apps/core/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Api _api;

  Future<bool> get isLogin async => await checkAuthToken();

  AuthService({Api api}) {
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
      sharedPreferences.setString(SharedPreferenceKey.ACCESS_TOKEN, resDecoded["result"]["token"]);
      sharedPreferences.setString(SharedPreferenceKey.USER, json.encode(resDecoded['result']));
      return resDecoded["success"];
    } else {
      throw(resDecoded["message"]);
    }
  }

  Future<bool> login(
      {String name, String phoneNumber, String email, String password}) async {
    final response = await _api.post(url: "v1/login", body: {
      "email": email,
      "password": password,
    });
    final resDecoded = json.decode(response);
    if (resDecoded["code"] == NetworkCode.SUCCESS) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(SharedPreferenceKey.ACCESS_TOKEN, resDecoded["result"]["token"]);
      sharedPreferences.setString(SharedPreferenceKey.USER, json.encode(resDecoded['result']));
      return resDecoded["success"];
    } else {
       throw(resDecoded["message"]);
    }
  }

  Future<bool> checkAuthToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferenceKey.ACCESS_TOKEN);
    final response = await _api.post(url: "v1/login-token", body: {
      "token": token,
    });
    final resDecoded = json.decode(response);
    if (resDecoded["code"] == NetworkCode.SUCCESS) {
      return resDecoded["result"]["isLogin"];
    } else {
      return false;
    }
  }

  Future<UserModel> loadUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserModel user = UserModel.fromJson(json.decode(sharedPreferences.getString(SharedPreferenceKey.USER)));
    return user;
  }

  Future<bool> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(SharedPreferenceKey.ACCESS_TOKEN);
    return true;
  }
}
