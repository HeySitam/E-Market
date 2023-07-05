import 'dart:io';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {

  @override
  Future<bool> get isConnected async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        isConnected = true;
      }
    } on SocketException catch (_) {
      print('not connected');
      isConnected = false;
    }

    return isConnected;
  }

}