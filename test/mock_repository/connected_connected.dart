import 'package:shirasu/client/connectivity_repository.dart';
import 'package:shirasu/client/connectivity_repository_impl.dart';

final kOverrideConnectedRepositoryConnectedImpl = kPrvConnectivityRepository
    .overrideWithValue(const _ConnectedRepositoryConnectedImpl());

class _ConnectedRepositoryConnectedImpl with ConnectivityRepository {

  const _ConnectedRepositoryConnectedImpl();

  @override
  Future<void> ensureNotDisconnect() async {}
}
