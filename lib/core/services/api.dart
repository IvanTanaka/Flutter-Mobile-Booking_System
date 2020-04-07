import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/constants/network_config.dart';
import 'package:member_apps/core/constants/shared_preference_key.dart';
import 'package:member_apps/core/services/auth_service.dart';
import 'package:member_apps/core/services/navigation_service.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum RequestMethod { POST, GET }

class Api {
  //TODO change the endpoint url
  static const _endpoint = '${NetworkConfig.DOMAIN_URL}api/';
  static const int _timeoutDuration = 30000;
  static const int maxCallApi = 3;

  Dio _dio;
  StreamController<DioError> _dioResponseStreamController;

  dispose(){
    _dioResponseStreamController.close();
  }

  Stream<DioError> get dioResponseStream => _dioResponseStreamController.stream;

  Api() {
    _dioResponseStreamController = StreamController<DioError>.broadcast();
    _dio = Dio();
    _dio.interceptors.add(LogInterceptor(
        request: true, requestBody: true, responseBody: true, error: true));
  }

  Future<dynamic> get(
      {String url}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    BaseOptions baseOptions = new BaseOptions();
    Map<String, dynamic> headerJson = {
      'Authorization':
      "Bearer ${sharedPreferences.getString(SharedPreferenceKey.ACCESS_TOKEN)}",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    baseOptions.connectTimeout = _timeoutDuration;
    baseOptions.receiveTimeout = _timeoutDuration;
    baseOptions.headers = headerJson;
    _dio.options = baseOptions;

    Response<dynamic> responseApi;

    responseApi = await _dio.get(_endpoint+url);
    try {
      responseApi = await _dio.get(_endpoint+url);
      _dioResponseStreamController.add(null);
      if (responseApi != null) {
        if (responseApi.data['code'] == NetworkCode.UNAUTHORIZED)
          setSessionExpired();
      }
      return jsonEncode(responseApi.data);
    } on DioError catch (dioError) {
      responseApi = dioError.response;
      if (responseApi != null) {
        if (responseApi.data['code'] == NetworkCode.UNAUTHORIZED)
          setSessionExpired();
      }
      return throw responseApi.data['message'];
    }
    return jsonEncode(responseApi.data);


  }

  Future<dynamic> post(
      {String url,
        dynamic body}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    BaseOptions baseOptions = new BaseOptions();
    Map<String, dynamic> headerJson = {
      'Authorization':
      "Bearer ${sharedPreferences.getString(SharedPreferenceKey.ACCESS_TOKEN)}",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    baseOptions.connectTimeout = _timeoutDuration;
    baseOptions.receiveTimeout = _timeoutDuration;
    baseOptions.headers = headerJson;
    _dio.options = baseOptions;

    Response<dynamic> responseApi;

    try {
      responseApi = await _dio.post(_endpoint+url,data: body);
      _dioResponseStreamController.add(null);
      if (responseApi != null) {
        if (responseApi.data['code'] == NetworkCode.UNAUTHORIZED)
          setSessionExpired();
      }
      return jsonEncode(responseApi.data);
    } on DioError catch (dioError) {
      responseApi = dioError.response;
      if (responseApi != null) {
        if (responseApi.data['code'] == NetworkCode.UNAUTHORIZED)
          setSessionExpired();
      }
      return throw responseApi.data['message'];
    }
    return jsonEncode(responseApi.data);
  }

}


setSessionExpired() async {
  bool response = await locator<AuthService>().logout();
  if (response)
    locator<NavigationService>().navigateAndReplaceTo(RoutePaths.Login);
}

