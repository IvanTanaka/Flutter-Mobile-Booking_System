import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';

enum ConnectionStatus { CONNECTED,DISCONNECTED,RECONNECTED }

class ConnectionService {
  ConnectionStatus hasConnection = ConnectionStatus.CONNECTED;
  StreamController<ConnectionStatus> connectionChangeController = StreamController.broadcast();
  BehaviorSubject<ConnectionStatus> connectionStatusStream = BehaviorSubject();
  Stream<ConnectionStatus> get connectionChange => connectionChangeController.stream;
  final Connectivity _connectivity = Connectivity();

  ConnectionService() {
    connectionStatusStream.add(ConnectionStatus.CONNECTED);
    connectionChangeController.add(ConnectionStatus.CONNECTED);
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  void dispose() {
    connectionChangeController.close();
  }

  Future<ConnectionStatus> checkConnection() async {
    ConnectionStatus previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('http://10.0.2.2:8000');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("Connected");
        hasConnection = ConnectionStatus.CONNECTED;
      } else {
        print("Disconnected");
        hasConnection = ConnectionStatus.DISCONNECTED;
      }
    } on SocketException catch (_) {
      print("Disconnected");
      hasConnection = ConnectionStatus.DISCONNECTED;
    }

    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
      connectionStatusStream.add(hasConnection);
    }
    return hasConnection;
  }
}
