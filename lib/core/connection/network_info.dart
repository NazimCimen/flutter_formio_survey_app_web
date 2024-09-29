import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// this interface is used to control internet connection.
abstract class INetworkInfo {
  Future<bool> get currentConnectivityResult;
}

class NetworkInfo implements INetworkInfo {
  final InternetConnection connectivity;

  NetworkInfo(this.connectivity);

  @override
  Future<bool> get currentConnectivityResult async {
    final result = await connectivity.hasInternetAccess;
    if (result) {
      return true;
    } else {
      return false;
    }
  }
}
