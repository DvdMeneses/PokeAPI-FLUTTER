import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Future<bool> checkConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      print('Error checking connectivity: $e');
      return false;
    }
  }

  Future<String> getConnectivityResultAsString() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result.toString();
    } catch (e) {
      print('Error getting connectivity as string: $e');
      return 'Error';
    }
  }

  @override
  String toString() {
    return getConnectivityResultAsString().toString();
  }
}
