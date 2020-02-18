import 'package:flutter/material.dart';
import 'package:member_apps/core/services/api.dart';
import 'package:member_apps/core/services/connection_service.dart';
import 'package:member_apps/service_locator.dart';
import 'package:provider/provider.dart';

import 'package:dio/dio.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;
  final Function() onError;

  BaseWidget(
      {Key key,
      this.builder,
      this.model,
      this.child,
      this.onModelReady,
      this.onError})
      : super(key: key);

  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }

    super.initState();
    // handle connection state
    ConnectionService connectionService = locator<ConnectionService>();
    connectionService.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(ConnectionStatus connectionStatus) {
    if (connectionStatus == ConnectionStatus.DISCONNECTED) {}
  }

  @override
  Widget build(BuildContext context) {
    return buildHandlerDioResponse();
  }

  Widget buildChangeNotifier() {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }

  Widget buildHandlerDioResponse() {
    return StreamBuilder<DioError>(
      stream: locator<Api>().dioResponseStream,
      builder: (context, snapshot) {
        DioError dioError = snapshot.data;
        if (dioError != null) {
          String errorMessage;
          switch (dioError.type) {
            case DioErrorType.RESPONSE:
              errorMessage =
                  mappingResponseStatus(dioError.response.statusCode);
              break;
            case DioErrorType.CANCEL:
              errorMessage = 'Cancel request api';
              break;
            case DioErrorType.CONNECT_TIMEOUT:
              errorMessage = 'Connection network timeout';
              break;
            case DioErrorType.RECEIVE_TIMEOUT:
              errorMessage = 'Receive data timeout';
              break;
            case DioErrorType.SEND_TIMEOUT:
              errorMessage = 'Send data timeout';
              break;
            default:
              break;
          }
          print(errorMessage);
        }
        return buildChangeNotifier();
      },
    );
  }

  String mappingResponseStatus(int statusCode) {
    String errorMessage;
    switch (statusCode) {
      case 400:
        errorMessage = "Request Not Complete";
        break;
      case 401:
        errorMessage = "Authorization Denied";
        break;
      case 404:
        errorMessage = "Data Not Found";
        break;
      case 500:
        errorMessage = "Server Error, please try again later";
        break;
    }
    return errorMessage;
  }
}
