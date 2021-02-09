import 'package:connectivity/connectivity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shirasu/client/connectivity_repository.dart';

final kPrvConnectivityRepository = Provider.autoDispose<ConnectivityRepository>(
    (ref) => ConnectivityRepositoryImpl());

class ConnectivityRepositoryImpl with ConnectivityRepository {

  /// @throws [NetworkDisconnectException]
  @override
  Future<void> ensureNotDisconnect() async {
    ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } catch (e) {
      print(e);
      //todo log error
    }

    if (result == ConnectivityResult.none)
      throw NetworkDisconnectException();
  }
}