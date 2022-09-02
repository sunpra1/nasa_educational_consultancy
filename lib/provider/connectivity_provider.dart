import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class ConnectivityProvider with ChangeNotifier {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  ConnectivityResult getConnectivityResult() => _connectivityResult;

  setConnectivityResult(ConnectivityResult connectivityResult) {
    if (_connectivityResult == connectivityResult) return;
    _connectivityResult = connectivityResult;
    notifyListeners();
  }
}
