import 'package:connectivity_plus/connectivity_plus.dart';

typedef ReconnectCallback = Future<void> Function();

class NetworkMonitor {
  final _connectivity = Connectivity();
  ReconnectCallback? _onReconnect;

  NetworkMonitor() {
    _connectivity.onConnectivityChanged.listen((status) {
      if (status != ConnectivityResult.none) {
        _onReconnect?.call();
      }
    });
  }

  void onReconnect(ReconnectCallback callback) {
    _onReconnect = callback;
  }
}
