import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:member_apps/core/constants/shared_preference_key.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum RequestMethod { POST, GET }

class Api {
  static const _mainPathDebug = 'https://dev.myislami.com/api/';
  static const _mainPathRelease = 'https://dev.myislami.com/api/';
  static const mainPath =
  kReleaseMode == true ? _mainPathRelease : _mainPathDebug;
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
      {String url,
        bool isAuthentication = false,
        bool isTesting = false}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(
        "GET TOKEN ${sharedPreferences.getString(SharedPreferenceKey.ACCESS_TOKEN)}");
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

    if (kDebugMode || kProfileMode) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
      };
    }
  }

  Future<dynamic> post(
      {String url,
        dynamic body,
        bool isAuthentication = false,
        bool isTesting = false}) async {
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

    if (kDebugMode || kProfileMode) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
      };
    }
  }

}

abstract class ResponseCode {
  static const SUCCESS = 200;
  static const UNAUTHORIZED = 401;
  static const NOT_FOUND = 404;
}
