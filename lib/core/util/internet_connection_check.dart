import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasInternetConnection() async {
  final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
  Log.i("connectivityResult=$connectivityResult");
  return connectivityResult != ConnectivityResult.none;
}

Future<bool> noInternetConnection() async {
  return !(await hasInternetConnection());
}

class InternetConnectionException implements Exception {

}